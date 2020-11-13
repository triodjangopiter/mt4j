#property copyright "Copyright © 2006-2017"
#property version "1.12"
#property strict

#include <Enums.mqh>
#include <Utils.mqh>
#include <Structures.mqh>


class PositionProvider
  {

   long              _magic;

   string            _position_pattern;

public:

                     PositionProvider(long magic)
     { _magic = magic; _position_pattern = "{ \"isHistory\": %s, \"type\": %s, \"magic\": %.0f, \"positionId\": %.0f, \"lot\": %.2f, \"stopLoss\": %.0f, \"takeProfit\": %.0f, \"openAt\": %.0f, \"closeAt\": %.0f, \"profit\": %.2f }"; }
                    ~PositionProvider() {}

public:

   string            GetPositions()
     {
      Position positions[];
      FetchPositions(positions);
      string items = "";
      int size = ArraySize(positions);
      for(int i = 0; i < size; i++)
        {
         string item = StringFormat(_position_pattern,
                                    BoolToString(positions[i].isHistory), PositionTypeToString(positions[i].type),
                                    positions[i].magic, positions[i].positionId, positions[i].lot, positions[i].stopLoss,
                                    positions[i].takeProfit, positions[i].openAt, positions[i].closeAt, positions[i].profit);
         items += item;
         if(i != size - 1)
            items += ", ";
        }

      return "[" + items + "]";
     }

private:

   void              FetchPositions(Position &positions[])
     {
      // -- MOCK EXAMPLE -- //
      Position mock1;
      mock1.magic = _magic;
      mock1.positionId = 48082938746378;
      mock1.isHistory = false;
      mock1.type = BUY;
      mock1.lot = 0.01;
      mock1.stopLoss = 100;
      mock1.takeProfit = 100;
      mock1.openAt = (long) TimeCurrent() * 1000;
      mock1.openAt = NULL;
      mock1.profit = 100.01;
      ArrayResize(positions, ArraySize(positions) + 1);
      positions[ArraySize(positions) - 1] = mock1;

      Position mock2;
      mock1.magic = _magic;
      mock2.positionId = 48082938754849;
      mock2.isHistory = true;
      mock2.type = SELL;
      mock2.lot = 0.01;
      mock2.stopLoss = 100;
      mock2.takeProfit = 100;
      mock2.openAt = (long) TimeCurrent() * 1000;
      mock2.openAt = NULL;
      mock2.profit = -6.01;
      ArrayResize(positions, ArraySize(positions) + 1);
      positions[ArraySize(positions) - 1] = mock2;
      // -- MOCK EXAMPLE -- //

      // todo Fetch all positions by magic
     }

  };