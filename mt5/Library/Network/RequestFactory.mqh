#property strict

#include <Library\ApplicationContext\ApplicationContext.mqh>

//+------------------------------------------------------------------+
//| Factory http request's body                                      |
//+------------------------------------------------------------------+
class CRequestFactory
  {
private:
   CMarketProvider *   market_provider;
   CAccountProvider *  account_provider;
   CPositionProvider * position_provider;
public:
                     CRequestFactory(void);
                    ~CRequestFactory(void);
public:
   string            GetAddAdvisorRequestBody(const string inputs);
   string            GetSignalRequestBody(const string advisor_id, string strategy_name);
  };

//+------------------------------------------------------------------+
//| Default constructor                                              |
//+------------------------------------------------------------------+
CRequestFactory::CRequestFactory(void)
  {
   market_provider = MarketProvider();
   account_provider = AccountProvider();
   position_provider = PositionProvider();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CRequestFactory::~CRequestFactory(void) {}
//+------------------------------------------------------------------+
//| Build requests body for register advisor                         |
//+------------------------------------------------------------------+
string CRequestFactory::GetAddAdvisorRequestBody(const string inputs)
  {
   return "{ \"magic\": " + (string) Magic() + ", \"inputs\": " + inputs + " }";
  }

//+------------------------------------------------------------------+
//| Build request body for fetch signal from remote resource         |
//+------------------------------------------------------------------+
string CRequestFactory::GetSignalRequestBody(const string advisor_id, const string strategy_name)
  {
   return "{ \"advisorId\": \"" +  advisor_id + "\", \"strategyName\": \"" + strategy_name +
          "\", \"rates\": " + market_provider.GetRates() +
          ", \"positions\": " + position_provider.GetPositions() +
          ", \"account\": " + account_provider.GetAccount() +
          " }";
  }
//+------------------------------------------------------------------+
