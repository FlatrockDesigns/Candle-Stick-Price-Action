//+------------------------------------------------------------------+
//|                                    Candle Stick Price Action.mq4 |
//|                                                 Flatrock Designs |
//|                                              FlatrockDesigns.com |
//+------------------------------------------------------------------+
#property copyright "Flatrock Designs"
#property link      "FlatrockDesigns.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectDelete(_Symbol,"Bid");
   ObjectDelete(_Symbol,"Doji1");
   ObjectDelete(_Symbol,"Doji2");
   ObjectDelete(_Symbol,"Doji3");
   ObjectDelete(_Symbol,"CandleLabel1");
   ObjectDelete(_Symbol,"CandleLabel2");
   ObjectDelete(_Symbol,"CandleLabel3");
   ObjectDelete(_Symbol,"CandleLabel4");
   ObjectDelete(_Symbol,"CandleLabel5");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
//Labels

   ObjectCreate(_Symbol,"Bid",OBJ_LABEL,0,0,0);
   ObjectSet("Bid",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("Bid",OBJPROP_XDISTANCE,350);
   ObjectSet("Bid",OBJPROP_YDISTANCE,30);
   ObjectSetText("Bid","Bid Price: "+DoubleToString(Bid,Digits),20,"Impact",HotPink);

   ObjectCreate(_Symbol,"CandleLabel1",OBJ_LABEL,0,0,0);
   ObjectSet("CandleLabel1",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("CandleLabel1",OBJPROP_XDISTANCE,350);
   ObjectSet("CandleLabel1",OBJPROP_YDISTANCE,60);

   ObjectCreate(_Symbol,"CandleLabel2",OBJ_LABEL,0,0,0);
   ObjectSet("CandleLabel2",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("CandleLabel2",OBJPROP_XDISTANCE,350);
   ObjectSet("CandleLabel2",OBJPROP_YDISTANCE,75);

   ObjectCreate(_Symbol,"CandleLabel3",OBJ_LABEL,0,0,0);
   ObjectSet("CandleLabel3",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("CandleLabel3",OBJPROP_XDISTANCE,350);
   ObjectSet("CandleLabel3",OBJPROP_YDISTANCE,90);

   ObjectCreate(_Symbol,"CandleLabel4",OBJ_LABEL,0,0,0);
   ObjectSet("CandleLabel4",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("CandleLabel4",OBJPROP_XDISTANCE,350);
   ObjectSet("CandleLabel4",OBJPROP_YDISTANCE,105);

   ObjectCreate(_Symbol,"CandleLabel5",OBJ_LABEL,0,0,0);
   ObjectSet("CandleLabel5",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("CandleLabel5",OBJPROP_XDISTANCE,350);
   ObjectSet("CandleLabel5",OBJPROP_YDISTANCE,120);

   ObjectCreate(_Symbol,"TradeSignal",OBJ_LABEL,0,0,0);
   ObjectSet("TradeSignal",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("TradeSignal",OBJPROP_XDISTANCE,10);
   ObjectSet("TradeSignal",OBJPROP_YDISTANCE,30);
   ObjectSetText("TradeSignal","Signal: Up or Down | Candle #",20,"Impact",Yellow);

   ObjectCreate(_Symbol,"TradeSignalEx",OBJ_LABEL,0,0,0);
   ObjectSet("TradeSignalEx",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("TradeSignalEx",OBJPROP_XDISTANCE,10);
   ObjectSet("TradeSignalEx",OBJPROP_YDISTANCE,60);
   ObjectSetText("TradeSignalEx","Reason for Signal: Bullish Engulfing, Hammer, ...",10,"Roboto",Yellow);

//Chart Indicators
   ObjectCreate(_Symbol,"Doji1",OBJ_ARROW,0,TimeCurrent(),Low[2]);
   ObjectSetInteger(_Symbol,"Doji1",OBJPROP_ARROWCODE,85);  //85 = +
   ObjectCreate(_Symbol,"Doji2",OBJ_ARROW,0,TimeCurrent(),Low[2]);
   ObjectSetInteger(_Symbol,"Doji2",OBJPROP_ARROWCODE,85);  //85 = +
   ObjectCreate(_Symbol,"Doji3",OBJ_ARROW,0,TimeCurrent(),Low[2]);
   ObjectSetInteger(_Symbol,"Doji3",OBJPROP_ARROWCODE,85);  //85 = +

   ObjectCreate(_Symbol,"BuySell",OBJ_ARROW,0,TimeCurrent(),Low[2]);

//Define Candle Info
   int candleHistoryCount = 20;
   double upperShadow[];
   ArrayResize(upperShadow,candleHistoryCount,0);
   double body[];
   ArrayResize(body,candleHistoryCount,0);
   double lowerShadow[];
   ArrayResize(lowerShadow,candleHistoryCount,0);
//int x;
   for(int x=0; x<candleHistoryCount; x++) //defin candle info arrays
     {
      upperShadow[x]=UShadowInfo(x);
      body[x]=BodyInfo(x);
      lowerShadow[x]=LShadowInfo(x);
     }
   double candleTimes[];
   ArrayResize(candleTimes,candleHistoryCount,0);

   candleTimes[0]=TimeCurrent();
   for(int x=1; x<candleHistoryCount; x++)
     {
      candleTimes[x] = TimeCurrent()-x*Period()*60; // TimeCurrent()-x*_Period*60 where x is number of candles back
      //Alert(candleTimes[x-1],"|",candleTimes[x]);
     }

// Chart Labels Output
   string CurrentCandle;
   CurrentCandle = CandleInfoLabel(0,"0 Current Candle",upperShadow,body,lowerShadow);
   string PastCandle;
   PastCandle = CandleInfoLabel(1,"1 Past Candle",upperShadow,body,lowerShadow);//"Past Candle: UShadow: "+ DoubleToString(UpperShadow1)+" | Body: "+DoubleToString(Body1)+" | LShadow: "+DoubleToString(LowerShadow1);
   string PastCandle2;
   PastCandle2 = CandleInfoLabel(2,"2 Candles Back",upperShadow,body,lowerShadow);//"2 Candles Back: UShadow: "+ DoubleToString(UpperShadow2)+" | Body: "+DoubleToString(Body2)+" | LShadow: "+DoubleToString(LowerShadow2);
   string PastCandle3;
   PastCandle3 = CandleInfoLabel(3,"3 Candles Back",upperShadow,body,lowerShadow);//"2 Candles Back: UShadow: "+ DoubleToString(UpperShadow2)+" | Body: "+DoubleToString(Body2)+" | LShadow: "+DoubleToString(LowerShadow2);
   string PastCandle4;
   PastCandle4 = CandleInfoLabel(4,"4 Candles Back",upperShadow,body,lowerShadow);//"2 Candles Back: UShadow: "+ DoubleToString(UpperShadow2)+" | Body: "+DoubleToString(Body2)+" | LShadow: "+DoubleToString(LowerShadow2);

   ObjectSetText("CandleLabel1",CurrentCandle,10,"Roboto",HotPink);
   ObjectSetText("CandleLabel2",PastCandle,10,"Roboto",HotPink);
   ObjectSetText("CandleLabel3",PastCandle2,10,"Roboto",HotPink);
   ObjectSetText("CandleLabel4",PastCandle3,10,"Roboto",HotPink);
   ObjectSetText("CandleLabel5",PastCandle4,10,"Roboto",HotPink);
//find dojis
   int foundDojis[];
   ArrayResize(foundDojis,candleHistoryCount,0);
   ArrayInitialize(foundDojis,candleHistoryCount-1);
   int count = 0;
   for(int x=1; x<candleHistoryCount; x++)
     {
      if(upperShadow[x]>body[x] &&body[x]<lowerShadow[x])
        {
         foundDojis[count]=x;
         count += 1;
        }
     }
//output Doji info to chart
   if(foundDojis[0]==candleHistoryCount-1)
     {
      ObjectSetInteger(_Symbol,"Doji1",OBJPROP_COLOR,LightSlateGray);
     }
   else
     {
      ObjectSetInteger(_Symbol,"Doji1",OBJPROP_COLOR,Yellow);
     }
   if(foundDojis[1]==candleHistoryCount-1)
     {
      ObjectSetInteger(_Symbol,"Doji2",OBJPROP_COLOR,LightSlateGray);
     }
   else
     {
      ObjectSetInteger(_Symbol,"Doji2",OBJPROP_COLOR,Yellow);
     }
   if(foundDojis[2]==candleHistoryCount-1)
     {
      ObjectSetInteger(_Symbol,"Doji3",OBJPROP_COLOR,LightSlateGray);
     }
   else
     {
      ObjectSetInteger(_Symbol,"Doji3",OBJPROP_COLOR,Yellow);
     }
   ObjectMove(_Symbol,"Doji1",0,candleTimes[foundDojis[0]],Low[foundDojis[0]]);
   ObjectMove(_Symbol,"Doji2",0,candleTimes[foundDojis[1]],Low[foundDojis[1]]);
   ObjectMove(_Symbol,"Doji3",0,candleTimes[foundDojis[2]],Low[foundDojis[2]]);
//signal variables
   int signalIndex = 2; //0=up,1=down,2=Null
   string signalReason="Reason for Signal: Bullish Engulfing, Hammer, ...";
   int signalCandle = 5;
//Engulfing - Bullish
   for(int x=2; x<candleHistoryCount; x++)
     {
      if(Close[x-1]-Open[x-1]>0) //one candle back is bearish
        {
         if(Open[x]-Close[x]>0) //one candle back is Bullish
           {
            //one candle back is Bullish
              {
               if(body[x-1]/2>=body[x])
                 {
                  signalIndex = 0; //0=up,1=down,2=Null
                  signalReason="Reason: Bullish Engulfing {(#"+IntegerToString(x-1)+")"+IntegerToString(body[x-1])+"/2>(#"+IntegerToString(x)+")"+IntegerToString(body[x])+")";
                  signalCandle = x-2;
                  break;
                 }
              }
           }
        }
     }
//Engulfing - Bearish
   for(int x=2; x<candleHistoryCount; x++)
     {
      if(signalCandle<x-2)
        {
         break;
        }
      else
        {
         if(Open[x-1]-Close[x-1]>0) //one candle back is Bullish
           {
            if(Close[x]-Open[x]>0)//one candle back is Bearish
              {
               if(body[x-1]/2>=body[x])
                 {
                  signalIndex = 1; //0=up,1=down,2=Null
                  signalReason="Reason: Bearish Engulfing {(#"+IntegerToString(x-1)+")"+IntegerToString(body[x-1])+"/2>=(#"+IntegerToString(x)+")"+IntegerToString(body[x])+"}";
                  signalCandle = x-2;
                  break;
                 }
              }
           }
        }
     }

//Signal Reporting
   if(signalIndex==0)
     {
      ObjectSetText("TradeSignal","Signal: Up | Candle "+IntegerToString(signalCandle),20,"Impact",Green);
      ObjectSetText("TradeSignalEx",signalReason,10,"Roboto",Green);
      ObjectSetInteger(_Symbol,"BuySell",OBJPROP_ARROWCODE,217);  //85 = +
      ObjectMove(_Symbol,"BuySell",0,candleTimes[signalCandle],Low[signalCandle]);
      ObjectSetInteger(_Symbol,"BuySell",OBJPROP_COLOR,Green);
     }
   else
      if(signalIndex==1)
        {
         ObjectSetText("TradeSignal","Signal: Down | Candle "+IntegerToString(signalCandle),20,"Impact",Red);
         ObjectSetText("TradeSignalEx",signalReason,10,"Roboto",Red);
         ObjectSetInteger(_Symbol,"BuySell",OBJPROP_ARROWCODE,218);  //85 = +
         ObjectMove(_Symbol,"BuySell",0,candleTimes[signalCandle],High[signalCandle]);
         ObjectSetInteger(_Symbol,"BuySell",OBJPROP_COLOR,Yellow);
        }
  }


//+------------------------------------------------------------------+
//| Upper Shadow Info                                                |
//+------------------------------------------------------------------+
double UShadowInfo(int index)
  {
   double UShadow=0.0;
   if(Open[index]-Close[index]>0)  // if Bear candle
     {
      UShadow = High[index]-Open[index];
     }
   else
      if(Open[index]-Close[index]<0)  // if Bull candle
        {
         UShadow = High[index]-Close[index];
        }
   return (UShadow);
  }
//+------------------------------------------------------------------+
//| Body Info                                                        |
//+------------------------------------------------------------------+
double BodyInfo(int index)
  {
   double Body=0.0;
   if(Open[index]-Close[index]>0)  // if Bear candle
     {
      Body = Open[index]-Close[index];
     }
   else
      if(Open[index]-Close[index]<0)  // if Bull candle
        {
         Body = Close[index]-Open[index];
        }
   return (Body);
  }
//+------------------------------------------------------------------+
//| Lower Shadow Info                                                |
//+------------------------------------------------------------------+
double LShadowInfo(int index)
  {
   double LShadow=0.0;
   if(Open[index]-Close[index]>0)  // if Bear candle
     {
      LShadow = Close[index]-Low[index];
     }
   else
      if(Open[index]-Close[index]<0)  // if Bull candle
        {
         LShadow = Open[index]-Low[index];
        }
   return (LShadow);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CandleInfoLabel(int index,string prefix,double& upperShadow[],double& body[],double& lowerShadow[])
  {
   return (prefix+": UShdw: "+ DoubleToString(upperShadow[index],4)+" | Body: "+DoubleToString(body[index],4)+" | LShdw: "+DoubleToString(lowerShadow[index],4));
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
