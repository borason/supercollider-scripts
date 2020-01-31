a = {SinOsc.ar(440)*0.1}.play

a.run(false) //turn off synthesis (saving CPU) without freeing the Synth

a.run //restore (defaults to a.run(true)

a.free //stop it explicitly: note that I didn't need to use the 'stop all' cmd+. or alt+. key command, and can individual kill specific Synths this way

(
a = {
	arg freq = 440, amp = 0.1;
	SinOsc.ar(freq) * amp;
}.play;
)

a.set(\freq, rrand(220, 440), \amp, rrand(0.1, 0.8));

