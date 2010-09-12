# active_bomb

active_bomb provides an ActiveResource base for interfacing your Rails
application against the [Giant Bomb API](http://api.giantbomb.com/).

## Usage

**config/initializers/giantbomb.rb:**

    require 'active_bomb'

    ActiveBomb::Base.api_key = 'theapikeygoeshere'

**app/models/Game.rb**:

    class Game < ActiveBomb::Base
    end
    
