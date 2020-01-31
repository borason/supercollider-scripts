{SinOsc.ar(mul:0.5)}.scope

{SinOsc.ar(mul:2.0)}.scope		//loud! defaults are 440 Hz, amplitude multiplier 2.0

{SinOsc.ar(mul:MouseY.kr(1.0,0.1))}.scope		//demo of amplitude scaling

{SinOsc.ar(mul: MouseX.kr(0.1, 1.0), add: MouseY.kr(0.9, -0.9))}.scope;

(
{
	//cutoff values need to be sensible frequencies in Hz; here sine output turned from -1 to 1 into 2000+-1700

	// var cutoff = 	SinOsc.ar(1,mul:MouseX.kr(0.0,1700.0), add:2000.0);

	var cutoff = SinOsc.ar(1)*1700.0 + 2000.0;  //same thing

	LPF.ar(WhiteNoise.ar,freq:cutoff);
}.scope;
)

{SinOsc.ar(440,0.0,0.1)}.scope			//provide freq and mul arguments directly

{SinOsc.ar(mul:0.1)}.scope			//provide just the multiplier argument explicitly

{0.1*SinOsc.ar}.scope					//multiply the SinOsc UGen by a constant

{SinOsc.ar(440, mul: -20.dbamp)}.scope   //use dBs! The conversion calculation is done just once at the


//initialisation of the UGen

{SinOsc.ar(SinOsc.ar(3,mul:40,add:440),0,0.1)}.scope

