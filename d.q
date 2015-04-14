// default data script (-ds)

\e 1
\P 14

/ example

symbol:`msft`amat`csco`intc`yhoo`aapl
trader:`chico`harpo`groucho`zeppo`moe`larry`curly`shemp`abbott`costello
sector:`energy`materials`industrials`financials`healthcare`utilities`infotech
strategy:`statarb`pairs`mergerarb`house`chart`indexarb

n:1000000
t:([]
 N:n#1;
 symbol:n?symbol;
 sector:n?sector;
 trader:n?trader;
 strategy:n?strategy;
 price:{0.01*"i"$100*x}20+n?400.;
 quantity:1+n?100; 
 date:2000.01.01+asc n?365;
 time:09:30:00.0+n?06:30)

t:update price_:price,wprice:price,wprice_:price from t

m:10
f:`$"f",'string til m
t:flip(flip 0!t),f!(m,n)#1000*-.5+(n*m)?1.

T:`t
G:`sector`trader`strategy`symbol
F:`N`wprice`wprice_`price`price_`quantity`date`time,f
A[`price_]:((sum;`price_);(%;`price_;`N))				/ map-reduce = (map;red)
A[`price]:(avg;`price)							/ bottom up version
A[`wprice_]:enlist({sum[x*y]%sum x};`quantity;`wprice_)			/ map, reduce is a no-op
A[`wprice]:(wavg;`quantity;`wprice)					/ bottom up version

/ update
.z.ts:{t[::;`quantity]+:-5+n?10;t[::;`price]+:-.5+n?1.;t[::;f]+:(n,m)#1000*-.5+(n*m)?1.;.js.ups`price`quantity,f;}

\

/ override default initial expansion
P:(([n:((`symbol$())					!();
        (1#`sector)					!1#`financials;
	 `sector`trader					!`financials`abbott;
	 `sector`trader					!`financials`curly;
	 `sector`trader`strategy			!`financials`curly`mergerarb;
	 `sector`trader`strategy`symbol			!`financials`curly`mergerarb`aapl;
	 (1#`sector)					!1#`industrials)]
	v:1111101b);([n:()]v:til 0))


