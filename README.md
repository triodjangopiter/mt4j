# Bridge
The local server based on Tomcat is the bridge between Java and Meta Trader 5 via HTTP requests.

Port `80`. Port can't be changed by specific Meta Trader 5 reason, see more in MQL5 documentation: [https://www.mql5.com/en/docs/network/webrequest][webrequest].

MetaTrader 5 required permission in settings for send http requests to localhost, see more in MQL5 documentation: [https://www.metatrader5.com/en/terminal/help/startworking/settings][settings]

Endpoints:

**POST** `/api/config` - set advisor config (Advisor bootstrap sync with a local server)
```json
{
    "config": "key_1=value_1\nkey_2=value_2"
}
```


**GET** `/api/signal` - resolve indicator's time series and return signal generated by plugged strategy.
```json
{
    "advisorId": "c4eb34e4-c9c3-4b7e-856d-d5d00588464d",
    "scenarioSysName": "simple",
    "indicators": [
        {
            "id": "42897b00-4d16-469f-81d0-def62b34606b",
            "type": "STOCHASTIC",
            "timeframe": "M_1",
            "buffer": [
                { "value": 37.38, "date": 1603488613812 },
                { "value": 39.23, "date": 1603488639826 },
                { "value": 42.07, "date": 1603488656337 }
            ]
        }
    ]
}
```


[webrequest]: https://www.mql5.com/en/docs/network/webrequest
[settings]:https://www.metatrader5.com/en/terminal/help/startworking/settings