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
}

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
			//~bike.value(EnvGen.kr(env, timeScale:quantity * 0.3,doneAction: 2))
			~car.value(frequency, EnvGen.kr(env, timeScale:quantity * 0.3,doneAction: 2))
		}
	);
};

{~carHorn.value(3)}.play;


