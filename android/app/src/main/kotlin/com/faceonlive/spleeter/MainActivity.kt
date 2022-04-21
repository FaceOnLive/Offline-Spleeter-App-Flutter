package com.faceonlive.spleeter

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import com.arthenica.mobileffmpeg.Config
import com.arthenica.mobileffmpeg.FFprobe
import com.arthenica.mobileffmpeg.FFmpeg
import com.arthenica.mobileffmpeg.ExecuteCallback
import com.arthenica.mobileffmpeg.Config.RETURN_CODE_CANCEL
import com.arthenica.mobileffmpeg.Config.RETURN_CODE_SUCCESS
import android.content.Context
import java.io.File
import com.ttv.spleeter.SpleeterSDK
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Handler
import android.os.Looper


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.turingalan.splitter"
    private var appCtx: Context?= null
    private var playSize: Int = 0
    private var audioTrack: AudioTrack? = null
    private var runningPlayThread: Boolean = false
    private var loadThread: Boolean = false
    private var loadFileName: String?= null
    private var playState: Boolean = false
    private var playSeek: Int = -1
    private var stemRatdio: FloatArray = FloatArray(5)
    private var channel: MethodChannel? = null

    init {
        appCtx = this

        val frameRate = 44100
        val minBufferSize = AudioTrack.getMinBufferSize(
            frameRate, AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT
        )
        val bufferSize = 3 * (minBufferSize / 2) and 3.inv()
        audioTrack = AudioTrack(
            AudioManager.STREAM_MUSIC,
            frameRate,
            AudioFormat.CHANNEL_OUT_STEREO,
            AudioFormat.ENCODING_PCM_16BIT,
            bufferSize,
            AudioTrack.MODE_STREAM)

        stemRatdio[0] = 1.0f
        stemRatdio[1] = 1.0f
        stemRatdio[2] = 1.0f
        stemRatdio[3] = 1.0f
        stemRatdio[4] = 1.0f
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel!!.setMethodCallHandler {
            call, result ->
            /// Set or Load Audio
            if(call.method.equals("loadAudio")){

                if(loadThread == false) {
                    loadThread = true;
                    var audioPath = call.argument<String>("audioPath")
                    loadFileName = audioPath

                    Thread(LoadThread()).start()
                    result.success(1)
                } else {
                    result.success(0)
                }
            }
            else if(call.method.equals("init")){

                // play the loaded audio that has been loaded by set Audio
                if(runningPlayThread == false) {
                    runningPlayThread = true
                    Thread(PlayThread()).start()

                    result.success(1)
                } else {
                    result.success(1)
                }
            }
            else if(call.method.equals("uninit")){

                // play the loaded audio that has been loaded by set Audio
                runningPlayThread = false
                playState = false
                playSeek = -1
                audioTrack!!.stop()
                SpleeterSDK.getInstance().stopProcess()
            }
            else if(call.method.equals("progress")){

                // play the loaded audio that has been loaded by set Audio
                val ret = SpleeterSDK.getInstance().progress()
                result.success(ret)
            }
            else if(call.method.equals("saveAllStem")){

                // play the loaded audio that has been loaded by set Audio
                var outFolderPath = call.argument<String>("outFolderPath")
                val ret = SpleeterSDK.getInstance().saveAllStem(outFolderPath)
                result.success(ret)
            }
            else if(call.method.equals("saveOne")){

                // play the loaded audio that has been loaded by set Audio
                var outWavePath = call.argument<String>("outWavePath")
                val ret = SpleeterSDK.getInstance().saveOne(outWavePath, stemRatdio)
                result.success(ret)
            }
            /// Play Audio
            else if(call.method.equals("play")){

                var seek = call.argument<Int>("seek") as Int
                if(seek < 0 || seek > playSize || playSize == 0) {
                    result.success(false)
                } else {
                    playState = false
                    audioTrack!!.pause()

                    var playRet: Boolean = false
                    // play the loaded audio that has been loaded by set Audio
                    while(true) {
                        val playBuffer = ShortArray(8192)
                        val ret = SpleeterSDK.getInstance().playbuffer(playBuffer, seek * 4, stemRatdio);
                        if(ret < 0) {
                            try {
                                Thread.sleep(30)
                            } catch (e:Exception) {}
                        } else if(ret == 0) {
                            playRet = false
                            break
                        } else {
                            playRet = true
                            break
                        }
                    }

                    if(playRet == false) {
                        result.success(false)
                    } else {
                        audioTrack!!.play()
                        playState = true
                        playSeek = seek
                        result.success(true)
                    }
                }
            }
            /// Pause Audio
            else if(call.method.equals("pause")){
                // pause audio here
                playState = false
                audioTrack!!.pause()
            }
            /// Adjust Audio
            else if(call.method.equals("adjust")){
                // Arugments
                var vocal = call.argument<Int?>("vocal")
                var bass = call.argument<Int?>("bass")
                var piano = call.argument<Int?>("piano")
                var drum = call.argument<Int?>("drum")
                var others = call.argument<Int?>("others")

                /* Note:
                * These adjust arguments can be null
                * If null then the default will stay
                * */

                if(vocal != null) {
                    stemRatdio[0] = vocal as Int * 1.0f / 100.0f
                }

                if(piano != null) {
                    stemRatdio[1] = piano as Int * 1.0f / 100.0f
                }

                if(drum != null) {
                    stemRatdio[2] = drum as Int * 1.0f / 100.0f
                }

                if(bass != null) {
                    stemRatdio[3] = bass as Int * 1.0f / 100.0f
                }

                if(others != null) {
                    stemRatdio[4] = others as Int * 1.0f / 100.0f
                }
            }
        }
    }

    inner class PlayThread : Runnable {
        override fun run() {

            val ret = SpleeterSDK.createInstance(appCtx).create()
            Handler(Looper.getMainLooper()).post(Runnable {
                channel!!.invokeMethod("onInited", ret)
            })

            while(runningPlayThread) {
                if(playState == false) {
                    Thread.sleep(30)
                    continue
                }
                if(playSeek < 0) {
                    Thread.sleep(30)
                    continue
                }

                val playBuffer = ShortArray(8192)
                val ret = SpleeterSDK.getInstance().playbuffer(playBuffer, playSeek * 4, stemRatdio);
                if(ret == 0) {
                    playState = false
                    playSeek = -1
                    audioTrack!!.stop()
                } else if(ret < 0) {
                    Thread.sleep(30)
                } else {
                    audioTrack!!.write(playBuffer, 0, playBuffer.size)

                    Handler(Looper.getMainLooper()).post(Runnable {
                        channel!!.invokeMethod("onPlayed", playSeek)
                    })

                    playSeek += ret / 4
                }
            }
        }
    }

    inner class LoadThread : Runnable {
        override fun run() {

            playState = false
            playSeek = -1
            audioTrack!!.stop()
            SpleeterSDK.getInstance().stopProcess()

            // Load The Audio
            val file = File(appCtx!!.filesDir.absolutePath  + "/input.wav")
            if(file.exists())
                file.delete()

            val inpPath = appCtx!!.filesDir.absolutePath  + "/input.wav"
            val cmd = "-i " + loadFileName + " " + inpPath
            val ret = FFmpeg.executeAsync(cmd, ExecuteCallback { executionId, returnCode ->
                if (returnCode == Config.RETURN_CODE_SUCCESS) {
                    try {
                        val outPath = appCtx!!.filesDir.absolutePath + "/out"
                        val f = File(outPath)
                        if (!f.exists()) {
                            f.mkdirs()
                        }

                        SpleeterSDK.getInstance().process(inpPath, outPath)
                        playSize = SpleeterSDK.getInstance().playsize()

//                            result.success(playSize)
                        loadThread = false;
                        Handler(Looper.getMainLooper()).post(Runnable {
                            channel!!.invokeMethod("onLoaded", playSize)
                        })

                    } catch (e:Exception){}
                } else if (returnCode == Config.RETURN_CODE_CANCEL) {
                    Log.e("TestEngine", "Async command execution cancelled by user.")
//                        result.success(0)
                    loadThread = false;
                    Handler(Looper.getMainLooper()).post(Runnable {
                        channel!!.invokeMethod("onLoaded", 0)
                    })
                } else {
                    // return true if the audio is loaded successfully or false
                    Log.e(
                        "TestEngine",
                        String.format(
                            "Async command execution failed with returnCode=%d.",
                            returnCode
                        )
                    )

                    loadThread = false;
                    Handler(Looper.getMainLooper()).post(Runnable {
                        channel!!.invokeMethod("onLoaded", 0)
                    })
                }
            })
        }
    }
}
