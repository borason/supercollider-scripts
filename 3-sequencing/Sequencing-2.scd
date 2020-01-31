(
SynthDef(\event, {
	arg freq = 440, pan = 0.0, amp = 0.5;
	var env;
	env = EnvGen.ar(Env([0, 1, 1, 0], [0.01, 0.1, 0.2]), doneAction: 2);

	Out.ar(0,  Pan2.ar(Blip.ar(freq) * env * amp, pan))
}).add;
)

Synth(\event);

Synth(\event,[\freq,880,\amp,0.2,\pan,1.0])

(
{
	Synth(\event);
	1.0.wait;
	Synth(\event);
}.fork;
)

// loop to play synth event
(
{
	4.do {
	Synth(\event);
	1.0.wait;
	}
}.fork;
)

// Illustrates loop
4.do {arg repeatnumber; repeatnumber.postln; "iteration complete".postln;};

(
{
	8.do {
		Synth(\event, [\freq, rrand(440, 880)]);
		1.0.wait;
	}
}.fork;
)