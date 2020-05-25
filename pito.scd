(
/* ------------------parametros-----------------------------
    pos: posicion en la cual se habilita el sonido
    quantity: cantidad de sonidos totales
   ---------------------------------------------------------
   Genera un array de niveles para el envelope
*/
~levelGenerator = {
	arg pos, quantity;
	var level = [];
		pos.do{
			7.do{
				level = level.add(0)
			}
		};
		6.do{ //
			level = level.add(1);
		};
		level = level.add(0);
		if((pos+1) != quantity, {
			for(pos +2, quantity, {
				for(0,6,{
					level = level.add(0)
				});
			level = level.add(0)
		});
		},{});
	level
};

~car = {
	arg frequency, mul = 0.5;
	LFSaw.ar(frequency, mul: mul)+
	LFSaw.ar(frequency - 70 - 20.rand,  mul: mul)
};

/* ------------------parametros-----------------------------
    quantity: cantidad de pitidos totales
   ---------------------------------------------------------
*/
~carHorn= {
	arg quantity;
	Mix.fill(quantity,
		{
			arg i;
			var frequency = rrand(420,512), mul, levels, times, env;
			levels = ~levelGenerator.value(i, quantity);
			if(quantity == 1, {times = [1]}, {times = Array.fill(quantity - 1, 1).normalizeSum;});
			env = Env.new(levels, times);
			~car.value(frequency, EnvGen.kr(env, timeScale:quantity * 0.25,doneAction: 2))
		}
	);
};

{~carHorn.value(8)}.play;
)

/*
========================FRENADO DE AIRE DE CAMION=================================
*/

(
~engine = {
	arg engineTime = 5;
	var envelope = Env.new([1,1,0],[engineTime *0.9, engineTime * 0.1]);
	BrownNoise.ar(0.2 * EnvGen.ar(envelope)) +
	(BrownNoise.ar(LFPulse.ar(12)) * 0.18 * EnvGen.ar(envelope, doneAction:2))
};

~airBrake= {
	arg waitingTime;
	var mulEnvelope = Env.new([0,0,0.5, 0.7,0],[waitingTime, 0.01, 0.6,0.01]);
	HPF.ar(BrownNoise.ar(EnvGen.ar(mulEnvelope)), 6000)
};

{ //Play Truck
	Pan2.ar(
	(~engine.value * 0.2) +
		(~airBrake.value(3) * 10))
}.play
)


