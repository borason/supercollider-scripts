Server.default.options.device_("Audient USB Audio ASIO Driver")

(
SynthDef(\event, { |out|
    Out.ar(out,
        SinOsc.ar(rrand(400, 800), 0, 0.2) * Line.kr(1, 0, 1, doneAction: Done.freeSelf)
    )
}).add;
)

(
{
	4.do{arg j;
		{
			8.do{arg i;
				Synth(\event, [\freq, (48+(i*3.3)+j).midicps,\amp,(1.0-(i/8))]);
				0.5.wait;
			}
		}.fork;
		4.0.wait;
	}
}.fork;
)


// 2 synth sounds
(
SynthDef(\sound1, {
	arg freq = 440, amp = 0.1;

	var sound;

	sound = LPF.ar(Saw.ar(freq), 2000) * Line.kr(1, 0, 0.1, doneAction: 2) * amp;

	Out.ar(0, Pan2.ar(sound, 0.0))
}).add;

SynthDef(\sound2, {
	arg freq = 440, amp = 0.1;
	var sound;

	sound = HPF.ar(LFPar.ar(freq), 1000) * Line.kr(0, 1, 0.5, doneAction: 2) * amp;
	Out.ar(0, Pan2.ar(sound, 0.0))
}).add;
)

Synth(\sound1);
Synth(\sound2);

(
var barlengths = [4.0, 3.5, 5.0];
var t = TempoClock(2.5);
{
	inf.do{|i|
		var barnow = barlengths.wrapAt(i);
		"new bar".postln;

		{
			var whichsound;
			whichsound = [\sound1, \sound2].choose;
			((barnow/0.25) - 2).floor.do{|j|

				Synth(whichsound, [\freq, 300 + (100*j), \amp, 0.3]);

				0.25.wait;

			};

		}.fork(t);

		barnow.wait;

	}
}.fork(t);
)