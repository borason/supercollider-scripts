// Substractive Synthesis

// White Noise into Filter
{LPF.ar(WhiteNoise.ar(1.0), 1000)!2}.play.scope;
// Line controlling filter cutoff
{LPF.ar(WhiteNoise.ar(1.0), Line.kr(10000, 1000, 1, doneAction: 2))!2}.play.scope;
{Resonz.ar(LFNoise0.ar(400), Line.kr(1000, 100, 1, doneAction:2), 0.1)!2}.play;
(
{
	var source, line, filter;
	source = LFNoise0.ar(400);
	line = Line.kr(10000, 100, 1, doneAction: 2);
	filter = Resonz.ar(source, line, 0.1);
	source = source!2;1
}.play
)

// Additive synthesis

// Sin Oscs added together
{SinOsc.ar([440, 600], 0, 0.1 )}.scope;

// Panning
{Pan2.ar(WhiteNoise.ar(0.1), MouseX.kr(-1, 1))}.play;

// Multichannel
// One method is to wrap the multichannel sound with a Mix UGen:

{Pan2.ar(Mix(SinOsc.ar([440, 600], 0, 0.1)), MouseX.kr(-1, 1))}.scope;

// Additive Sawtooth
// Sawtooth wave: Add up n harmonics with amplitude falling off as 1/harmonicnumber, sign alternates between +1 and -1

(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|
    var mult= ((-1)**i)*(0.5/((i+1)));
   	SinOsc.ar(440*(i+1))*mult
    });
	Pan2.ar(wave/n,0.0); //stereo, panned centre
}.scope;
)

// Square wave: Sum of odd harmonics, no even, amplitude falls as off 1/harmonicnumber; closest 'real' waveform is a clarinet tone

(

{

	var n = 10;

	var wave = Mix.fill(10,{|i|
			var harmonicnumber = 2*i+1; //odd harmonics only
			SinOsc.ar(440*harmonicnumber)/harmonicnumber
		})*0.25;

	Pan2.ar(wave,0.0); //stereo, panned centre

}.scope;
)

// Triangle wave: also odd harmonics only, falls off as 1 over harmonicnumber squared with alternating sign

(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|

		var harmonicnumber= 2*i+1; //odd harmonics only
    	var mult= ((-1)**((harmonicnumber-1)/2))*(1.0/(harmonicnumber*harmonicnumber));

		SinOsc.ar(440*harmonicnumber)*mult })/n;
	Pan2.ar(wave,0.0); //stereo, panned centre
}.scope;
)

{Mix(SinOsc.ar(500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1))}.scope //bell spectra, all partials the same volume

{Mix(SinOsc.ar(500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1*[0.25,1,0.8,0.5,0.9,0.4,0.3,0.6,0.1]))}.scope //bell spectra, different volumes for partials

// Here is a generalisable patch that uses the variable n to hold the number of sine tones desired for each run of the code:

(

var n = 10;



{Mix(SinOsc.ar(250*(1..n),0,1/n))}.scope;



)

