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