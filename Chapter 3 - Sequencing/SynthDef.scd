// First synthdef
(
SynthDef(\sine, {
	Out.ar(0, SinOsc.ar(Rand(440, 880), 0, 0.1))
}).add
)

Synth(\sine)

s.serverRunning

(
SynthDef(\sine, {
	arg freq = 440, amp = 0.1;
	Out.ar(0, SinOsc.ar(freq, 0, amp));
}).add;
)

Synth(\sine);

(
SynthDef(\sine, {
	arg freq = 440, amp = 0.1;
	Out.ar(0, SinOsc.ar(Rand(freq, 880), 0, amp));
}).add;
)

Synth(\sine);