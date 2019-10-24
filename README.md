# analyticslove
Google Analytics reporting for Lua LÖVE game engine. It uses Measurement protocol.

Pageviews, events and transactions (standard ecommerce) are supported.

## Code examples
```
local analytics=require('analytics')

analytics.setID('UA-2734538-6') -- set your property ID
analytics.resetClientID() -- generate random clientID

-- Send pageview
analytics.view('/example-path', 'Example_title')

-- Send event
analytics.event('event_category', 'click', 'special')

-- Send transaction with a product
analytics.transaction('T11345', 100, 5, 15)
analytics.transactionItem('T11345', 'product_super', 'P98765', 50, 2)
```

See the analytics.lua for more info.