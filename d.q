// default data script (-ds)

\e 1
\P 14

/ example 2

traders:(`$read0`:../yahoo/traders.txt)except`
stocks:`sym`name`lastsale`marketcap`ipoyear`sector`industry xcol("SSFSSSS";1#",")0:`:../yahoo/stocks.csv

yahoo:{[offset;stocks]
 tbl:();i:0;zs:(ze:.z.d)-offset;
 parms:"&d=",(string -1+`mm$ze),"&e=",(string`dd$ze),"&f=",(string`year$ze),"&g=d&a=",(string -1+`mm$zs),"&b=",(string`dd$zs),"&c=",(string`year$zs),"&ignore=.csv";
 do[count stocks:distinct stocks,();
  txt:`:http://ichart.finance.yahoo.com "GET /table.csv?s=",(string stock:stocks[i]),parms," http/1.0\r\nhost:ichart.finance.yahoo.com\r\n\r\n";
  if[0=count ss[txt;"404 Not Found"];tbl,:update Sym:stock from select from ("DEEEEI ";1#",")0:(txt ss"Date,Open")_ txt];
  i+:1];
 (lower cols tbl)xcol`Date`Sym xasc select from tbl where not null Volume}  

t:update N:1 from yahoo[30]exec sym from stocks where i in neg[rand 200]?count sym
t:t lj 1!stocks
t:raze{update trader:count[sym]#x from select from t where i in neg[rand count sym]?count sym}each traders
t:update mpl:sum pnl by"m"$date,sym from update pnl:0^volume*close-prev close by sym from t
t:update row:i from t

/ connect to hypertable:
T:`t
G:`trader`date`sector`industry`sym
F:`N`row`open`high`low`close`volume`pnl`mpl`lastsale`marketcap`ipoyear
A[f]:avg,/:f:`open`high`low`close`pnl`mpl
A[`volume]:(max;`volume)
A[`row]:(last;`row)
L:0b

/ update
.z.ts:{
 n:count t;
 t[::;`volume]+:-1 1[n?2]*n?100;
 t::update mpl:sum pnl by"m"$date,sym from update pnl:0^volume*close-prev close by sym,trader from t;
 .js.upd`;
 }

\

/ example 1

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
 quantity:-1 1[n?2]*n?100; 
 date:2000.01.01+asc n?365;
 time:09:30:00.0+n?06:30)

t:update price_:price,wprice:price,wprice_:price from t
t:update pnl:quantity*price-prev price by symbol from t

T:`t
G:`sector`trader`strategy`symbol
F:`N`pnl`wprice`wprice_`price`price_`quantity`date`time
A[`price_]:((sum;`price_);(%;`price_;`N))				/ map-reduce = (map;red)
A[`price]:(avg;`price)							/ bottom up version
A[`wprice_]:enlist parse"sum[wprice_*quantity]%sum quantity"		/ map, reduce is elided
A[`wprice]:(wavg;`quantity;`wprice)					/ bottom up version
A[`pnl]:(avg;`pnl)

/ update
.z.ts:{
 t[::;`quantity]+:-1 1[n?2]*n?100;t[::;`price]+:-.5+n?1.;
 t::update pnl:quantity*price-prev price by symbol from t;
 .js.upd`;
 }

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

\

/ example 3

t:get`:../../itunes

T:`t
G:`Genre`Album`Artist`Name
F:`Size`Total_Time`Disc_Number`Disc_Count`Track_Number`Track_Count`Year`Bit_Rate`Sample_Rate`Date_Added`Date_Modified
L:0b

Max:{max 0^x}
A[`Year]:(Max;`Year)
A[`Disc_Number]:(Max;`Disc_Number)
A[`Bit_Rate]:(Max;`Bit_Rate)
A[`Sample_Rate]:(Max;`Sample_Rate)

\
