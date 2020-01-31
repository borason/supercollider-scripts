// Envelopes

Env([1, 0, 1], [1,1]).plot

//various types of envelope demonstrated:

Env([0,1,0],[1.0,0.5]).plot  //one second 0 to 1 then half a second 1 to 0
Env.linen(0.03,0.5,0.1).plot  //linen has attackTime, sustainTime, releaseTime, level, curve

Env.adsr(0.01, 0.5, 0.5, 0.1, 1.0, 0).plot  //attackTime, decayTime, sustainLevel, releaseTime,peakLevel, curve

//note that the sustain portion is not shown in time; this particular envelope type deals with variable hold times, and the hold is missed out in the plot

// Here's another type of Envelope, good for making percussion sounds:

Env.perc(0.05,0.5,1.0,0).plot //arguments attackTime, releaseTime, level, curve: good for percussive hit envelopes

(
{
	var env, sig;
	sig = SinOsc.ar(440, 0, 0.1);
	env = EnvGen.ar(
		Env([1, 0], 1.0)
	);
	sig = (sig * env)!2;
}.scope;
)

// Envelope for frequency
{Saw.ar(EnvGen.ar(Env([1000,20],[1.0])),0.1)}.scope

{Saw.ar(EnvGen.ar(Env([10000,20],[0.5])),EnvGen.ar(Env([0.1,0],[2.0])))}.scope

(
{
	Saw.ar(
		EnvGen.kr(
			Env([1000, 20], [0.5])),
		EnvGen.kr(
			Env([0.1, 0], [2.0])
		)
	)!2
}.play;
)

(
{
	SinOsc.ar(
		SinOsc.ar(10,0,10,440),
		0.0,
		EnvGen.kr(Env([0.5,0.0],[1.0]), doneAction:2)   //doneAction:2 appears again, the deallocation operation
	)
}.scope;
)

{Saw.ar(SinOsc.ar(1, 0, 10, 440), Line.kr(0,1,1,doneAction:2))}.scope

{Saw.ar(SinOsc.ar(1,0,10,440),XLine.kr(0.0001,1,1,doneAction:2))}.scope

{XLine(0.0001,1,1)}.plot;

{EnvGen.ar(Env([0,0.1,0],[0.1,0.9]),doneAction:2)*SinOsc.ar(330)}.play
a = {EnvGen.ar(Env.asr(0.1,0.1,1.0),doneAction:2)*SinOsc.ar(330)}.play //sound continues
a.release(2.0); //let it finish, taking 2.0 seconds to fade out (it then deallocates, due to the doneAction:2)

a = {arg gate=1; EnvGen.ar(Env.asr(0.1,0.1,0.9),gate,doneAction:2)*SinOsc.ar(330)}.play

a.set(\gate,0) //when gate is set to 0, the envelope can finish, and takes 0.9 seconds to fade out (releaseTime argument to Env.asr set above)

e = Env([0.2,1.0,0.0],[0.1,3.0],0,1); //releaseNode at node 1, which is the pair of 0.0 level in the first array and 3.0 seconds in the second.

a= {arg gate=1; EnvGen.ar(e,gate,doneAction:2)*SinOsc.ar(550,0,0.1)}.play

a.set(\gate, 0); //takes 3.0 seconds to fade out


// Looping Envelope
e = Env([0.0,0.0,1.0,0.0],[0.5,1.0,2.0],0,2,0); //releaseNode at 2, loopNode at 0

a= {arg gate=1; EnvGen.ar(e,gate,doneAction:2)*SinOsc.ar(550,0,0.1)}.play

a.set(\gate, 0); //takes 2.0 seconds to fade out

// Fast Looping envelopes

e = Env([0.0,1.0,-1.0,0.0],[0.01,0.01,2.0],0,2,0); //releaseNode at 2, loopNode at 0

e.plot;

a= {arg gate=1; EnvGen.ar(e,gate,timeScale:MouseX.kr(0.1,2.0),doneAction:2)}.play

a.set(\gate, 0); //stops immediately since release transition to 0.0 occurs over 2 seconds, too slow to be a pitched oscillation

