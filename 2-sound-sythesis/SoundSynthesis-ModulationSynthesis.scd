(
{
	var carrier, modulator, carrfreq, modfreq;

	carrfreq = MouseX.kr(440, 5000, 'exponential');
	modfreq = MouseY.kr(1, 5000, 'exponential');

	carrier = SinOsc.ar(carrfreq, 0, 0.5);
	modulator = SinOsc.ar(modfreq, 0, 0.5);

	carrier * modulator;
}.scope;
)

{SinOsc.ar(440, 0, 0.5)}.scope;

Server.default.options.outDevice_("Background Music");

{SinOsc.ar(440, 0, 0.5, 0.5)}.scope;

(
{
	var carrier, modulator, carrfreq, modfreq;

	carrfreq = MouseX.kr(440, 5000, 'exponential');
	modfreq = MouseY.kr(1, 5000, 'exponential');

	carrier = SinOsc.ar(carrfreq, 0, 0.5);
	modulator = SinOsc.ar(modfreq, 0, 0.25, 0.25¡);

	carrier * modulator;
}.scope;
)

// FM Synth

(
{
	var w, carrfreqslider, modfreqslider, moddepthslider, synth;

	w = Window("frequency modulation", Rect(100, 400, 400, 300));
	w.view.decorator = FlowLayout(w.view.bounds);

	synth = {
		arg carrfreq = 440, modfreq = 1, moddepth = 0.01;
		SinOsc.ar(carrfreq + (moddepth * SinOsc.ar(modfreq)), 0, 0.25)
	}.scope;

	carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});

	w.view.decorator.nextLine;
	modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});

	w.view.decorator.nextLine;

	moddepthslider= EZSlider(w, 300@50, "moddepth", ControlSpec(0.01, 5000, 'exponential', 0.01, 0.01), {|ez|  synth.set(\moddepth, ez.value)});

	w.front;
}.scope;
)

// Mod index

(

var w, carrfreqslider, modfreqslider, modindexslider, synth;

w=Window("frequency modulation via modulation index", Rect(100, 400, 400, 300));

w.view.decorator = FlowLayout(w.view.bounds);

synth= {arg carrfreq=440, modfreq=1, modindex=0;

SinOsc.ar(carrfreq + (modindex*modfreq*SinOsc.ar(modfreq)),0,0.25)

}.scope;

carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});

w.view.decorator.nextLine;

modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});

w.view.decorator.nextLine;

modindexslider= EZSlider(w, 300@50, "modindex", ControlSpec(0.0, 10, 'linear', 0.01, 0.0), {|ez|  synth.set(\modindex, ez.value)});

w.front;
)

// Mouse Control
(
{
var modfreq, modindex;

modfreq= MouseX.kr(1,440, 'exponential');

modindex=MouseY.kr(0.0,10.0);

SinOsc.ar(SinOsc.ar(modfreq,0,modfreq*modindex, 440),0,0.25)

}.scope

)

// Phase Modulation

(

var w, carrfreqslider, modfreqslider, modindexslider, synth;
var conversion= 2pi/(s.sampleRate); //needed to avoid phase being adjusted too wildly

w=Window("phase modulation via modulation index", Rect(100, 400, 400, 300));

w.view.decorator = FlowLayout(w.view.bounds);

synth= {arg carrfreq=440, modfreq=1, modindex=0;

SinOsc.ar(carrfreq, ( (modfreq*modindex)*conversion*SinOsc.ar(modfreq)),0.25)

}.scope;

carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});

w.view.decorator.nextLine;

modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});

w.view.decorator.nextLine;

//bigger range since adjusting phase directly and not frequency

modindexslider= EZSlider(w, 300@50, "modindex", ControlSpec(0.0, 100, 'linear', 0.01, 0.0), {|ez|  synth.set(\modindex, ez.value)});

w.front;
)

