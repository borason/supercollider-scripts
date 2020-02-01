Server.default.options.device_("Audient USB Audio ASIO Driver");

{SinOsc.ar(440)}.play;

{Impulse.ar(MouseX.kr(1, 100))}.play;

{Dust.ar(MouseX.kr(1, 100))}.play;

(
{
	[
		LFNoise0(100),
		LFNoise1(100),
		LFNoise2(100)
	]
}.plot(0.1)
)

{ Stepper.ar(Impulse.ar(100), 0, 1, 10, 1) }.plot(0.3, minval:0, maxval:10);

{ SinOsc.ar(Stepper.ar(Impulse.ar(100), 0, 1, 10, 1) * 100, 0, 0.1) }.play;

{Saw.ar(Select.kr(Stepper.kr(Impulse.kr(MouseX.kr(1, 40), 0.1), 0, 0, 7, 1), [75, 63, 67, 72, 55, 62, 63, 63, 60].midicps), 0.1)}.play

// Sequenced Saw with filter control
(
{
LPF.ar(Saw.ar(Select.kr(Stepper.kr(Impulse.kr(MouseX.kr(1, 40), 0.1), 0, 0, 7, 1), [75, 63, 67, 72, 55, 62, 63, 63, 60].midicps), 0.1), MouseY.kr(500, 10000))
}.play;
)


(
{
	var source = SinOsc(100);

	[source, Trig1.ar(source, 0.001)]
}.plot
)

// trigger whenever crossing from negative to positive
(
{
	var source, trigger;

	source = LFNoise0.ar(100);
	trigger = Trig1.ar(source, 0.001);

	[source, trigger]
}.plot(0.2)
)

//trigger on any change

(
{
	var source, trigger;

	source = LFNoise0.ar(100);
	trigger = Trig1.ar(abs(source-Delay1.ar(source)), 0.001);

	[source, trigger]
}.plot(0.2)
)

// Grabs a sin osc and holds it
(
{
	Latch.ar(SinOsc.ar(1000),Impulse.ar(100));
}.plot(0.5);
)

// Grabs noise and samples

(
{
	Latch.ar(LFNoise0.ar(100), Impulse.ar(100));
}.plot(0.1);
)


(
{
	SinOsc.ar(300+(200*Latch.ar(SinOsc.ar(13.3), Impulse.ar(10))))*0.2
}.play
)

//Non sustaining envelopes

(
{
	EnvGen.ar(Env([0,1,0], [0.01, 0.01]), Impulse.kr(50));
}.plot(0.1)
)

// If you set this envelope carefully, could be used like a flexible stepper

(
{
	EnvGen.ar(Env([0,1,0,0.5, -0.4], 0.01!4), Impulse.kr(25))
}.plot(0.1)
)

// Use midicps on output to get scales

(
{
	SinOsc.ar(
		EnvGen.ar(
			Env([63, 63, 60, 55, 60], 0.125!4, curve: \step),
			Impulse.kr(2)
		).midicps
	)
}.play
)

// Percussive sound retriggered 3 times per second

(
{
	var sound, env, trig;

	trig = Impulse.ar(3); // trigger source

	sound = Mix(LFPulse.ar(110 * [1, 5/2], 0.0, 0.5, 0.2));

	env = EnvGen.ar(Env.perc(0.02, 0.2), trig); //with retriggering controlled by impulse

	Pan2.ar(sound * env, 0.0)
}.play
)

(
SynthDef(\mytriggersynth, {
	arg trig = 0;
	var env;

	// must have additional starting level in envelope or else no nodes to go back to
	env = EnvGen.ar(Env([2,2,1], [0.0, 0.5], 'exponential'), trig);

	Out.ar(0, Pan2.ar(Resonz.ar(Saw.ar(env*440), 1000, 0.1), 0.0))
},[\tr]).add
)

a = Synth(\mytriggersynth);

a.set(\trig, 1);


/*
Another triggering example: you could collect triggers from one signal and use them to spawn changes in another part of the UGen graph*/

//value of third frequency component is a new random number with each trigger

(
{
	var sound, env, trig;
	// > is itself a UGen when used in this context; it is outputting the result of comparing the LFNoise0 with the value 0 every sample!
	trig = LFNoise0.ar(13) > 0; //trigger source (might also use Dust, for example)

	// TRand chooses a random number in its range when triggered
	sound = Mix(LFPulse.ar(110 * [1, 5/2, TRand.ar(2,3.9, 4.1, trig)], 0.0, 0.5, 0.2));

	env = EnvGen.ar(Env.perc(0.01, 0.1), trig); //with retriggering controlled by impulse

	Pan2.ar(sound * env, 0.0)
}.play
)

/* Some oscillators can be retriggered, for example SyncSaw For sync oscillators:
   hard sync = immediate reset of slave oscillator
   soft sync = wait till start of next period for a reset of state
   The final frequency and timbre is an interaction of the frequency of the slave oscillator and the     syncing (resetting) signal
*/

{ Pan2.ar(SyncSaw.ar(MouseX.kr(1, 400), MouseY.kr(400, 800), 0.1)) }.play;

// Making a custom hard sync oscillator using an EnvGen and a trigger source

{EnvGen.ar(Env([0,0,1,-1,0],MouseY.kr(0,1)*[0,128,256,128]/SampleRate.ir),Impulse.ar(MouseX.kr(10,300,'exponential')))}.play;


(
{
	var source;

	source = LFNoise0.ar(10);

	[
		source,
		source.lag(0.1)
	]
}.plot(1.0);
)

{Saw.ar((Stepper.ar(Impulse.ar(10),0,1,10,1)*200).lag(MouseX.kr(0.0,0.2)))}.play

{Ringz.ar(Saw.ar(LFNoise0.kr(5).lag(0.1).exprange(100, 2000), 0.2), 1000, 0.01)}.play;

{Pan2.ar(Ringz.ar(Saw.ar(LFNoise0.kr(5).lag(MouseX.kr(0.01, 0.3)).exprange(100, 2000).round(20), 0.2), 1000, 0.01))}.play;

// Decay UGen can be used to put a smoothed tail on an impulse

(
{
	Decay.ar(Impulse.ar(100), 0.01)
}.plot(0.1)
)

(
{
	Decay2.ar(Impulse.ar(100), 0.005, 0.01)
}.plot(0.1)
)

