Server.default=s=Server.local;

s.boot;

b=Buffer.alloc(s, 10*44100, 1);  // s= server, 10*44100 num frames, 1 = 1 channel, i.e. mono

b.bufnum 	//which buffer are we using? This is an essential parameter to pass to lots of UGens

//restore that memory and free that bufferID

b.free

(

//this loads into a buffer the default sound that comes with SuperCollider

//.read brings in the whole sound at once

b = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav"); //store handle to Buffer in global variable b



SynthDef("playbuf",{ arg out=0,bufnum=0, rate=1, trigger=1, startPos=0, loop=1;

	Out.ar(out,

		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop),0.0)

	)

}).add;

)

Synth(\playbuf, [\out, 0, \bufnum, b.bufnum]);

Synth(\playbuf, [\out, 0, \bufnum, b.bufnum, \rate,- 1.0]);


(

var w, rateslid, trigslid, startposslid, loopslid, a;

a=Synth(\playbuf, [\out, 0, \bufnum, b.bufnum]);

w=Window("PlayBuf Example",Rect(10,200,300,150));

w.front;

//control positioning of new GUI elements so I don't have to think too hard about it

w.view.decorator= FlowLayout(w.view.bounds);

//James' shortcut slider class

//250@24 means a Point of size 250 by 24

//|ez| is the same as arg ez;  - the EZSlider object is being passed into the callback action function

rateslid= EZSlider(w, 250@24, "Rate", ControlSpec(0.5, 10, 'exponential', 0.1), {|ez| a.set(\rate,ez.value)}, 1);

trigslid= EZSlider(w, 250@24, "Trigger", ControlSpec(0, 1, 'lin', 1), {|ez| a.set(\trigger,ez.value)}, 1);

startposslid= EZSlider(w, 250@24, "StartPos", ControlSpec(0.0, 1.0, 'lin', 0.01), {|ez| a.set(\startPos,ez.value)}, 0);

loopslid= EZSlider(w, 250@24, "Loop", ControlSpec(0, 1, 'lin', 0.1), {|ez| a.set(\loop,ez.value)}, 1);

w.onClose_({a.free;});

)