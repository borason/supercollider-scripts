{LPF.ar(WhiteNoise.ar(1.0), 1000)!2}.play.scope;
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