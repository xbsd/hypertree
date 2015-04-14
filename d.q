// default data script (-ds)

\e 1
\P 14

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
 quantity:-49+n?100; 
 date:2000.01.01+asc n?365;
 time:09:30:00.0+n?06:30)

t:update price_:price,wprice:price,wprice_:price from t

T:`t
G:`sector`trader`strategy`symbol
F:`N`wprice`wprice_`price`price_`quantity`date`time
A[`price_]:((sum;`price_);(%;`price_;`N))				/ map-reduce = (map;red)
A[`price]:(avg;`price)							/ bottom up version
A[`wprice_]:enlist parse"sum[wprice_*quantity]%sum quantity"		/ map, reduce is elided
A[`wprice]:(wavg;`quantity;`wprice)					/ bottom up version

/ update
.z.ts:{t[::;`quantity]+:-49+n?100;t[::;`price]+:-.5+n?1.;.js.upd`;}

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

/ example 2

/ simon garland:
yahoo:{[offset;stocks]
 tbl:();i:0;zs:(ze:.z.d)-offset;
 parms:"&d=",(string -1+`mm$ze),"&e=",(string`dd$ze),"&f=",(string`year$ze),"&g=d&a=",(string -1+`mm$zs),"&b=",(string`dd$zs),"&c=",(string`year$zs),"&ignore=.csv";
 do[count stocks:distinct stocks,();
  txt:`:http://ichart.finance.yahoo.com "GET /table.csv?s=",(string stock:stocks[i]),parms," http/1.0\r\nhost:ichart.finance.yahoo.com\r\n\r\n";
  tbl,:update Sym:stock from select from ("DEEEEI ";enlist",")0:(txt ss"Date,Open")_ txt;i+:1];
 (lower cols tbl)xcol`Date`Sym xasc select from tbl where not null Volume}  

/ ed bierly:
u:yahoo[1000]`GOOG`MSFT`AAPL`CSCO`IBM`INTL
t:update N:1,mpl:sum pnl by"m"$date,sym from update pnl:0^volume*close-prev close by sym from u

/ connect to hypertable:
T:`t
G:`sym`date
F:`N,f:`open`high`low`close`volume`pnl`mpl
A[f]:avg,/:f

\
