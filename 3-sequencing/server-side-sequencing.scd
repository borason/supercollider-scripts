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