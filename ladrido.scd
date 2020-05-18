(
~ladrido = {
	arg mul;
	var env, env2;
	env = Env.new([Rand(100,300), Rand(900,1000), Rand(400,450), Rand(400,450)], [[0.1, 0.04, 0.2]] );
	env2 = Env.new([Rand(100,300), Rand(900*mul,1000*mul), Rand(400*mul,450*mul), Rand(400*mul,450*mul)], [[0.1, 0.04, 0.2]] );
	(
		SinOsc.ar(EnvGen.kr(env2, doneAction:2)) +
		SinOsc.ar(EnvGen.kr(env2, doneAction:2)) +
		SinOsc.ar(EnvGen.kr(env, doneAction:2)) +
		SinOsc.ar(EnvGen.kr(env, doneAction:2))
	)
}
)

{~ladrido.value(0.6)}.play;