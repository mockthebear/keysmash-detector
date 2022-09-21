# KeySmash-Detector

Detect if the word is a keysmash or not. 
Returns (**BOOLEAN**, Reason:**STRING**, Score:**FLOAT**)

# Usage

Syntax isKeySmash(<string>)

```lua
local keysmash = require("keysmash.lua")
assert(not keysmash.isKeySmash("cake"))
assert(not keysmash.isKeySmash("useful"))
assert(not keysmash.isKeySmash("pneumonoultramicroscopicsilicovolcanoconiosis"))
assert(not keysmash.isKeySmash("aeuhehuaehauehuaehaueh"))
assert(not keysmash.isKeySmash("KOPASKSPOAKSPOKSOPAKSPOAKSPOA"))

assert(keysmash.isKeySmash("klashjdlkjsdhfjklsdh"))
assert(keysmash.isKeySmash("ASLKDJSALKDJASLKDJASLK"))
assert(keysmash.isKeySmash("goodnessalsdgkwnlzkgjkssd"))
assert(keysmash.isKeySmash("AKXZNVJLKKSALDFKALD"))
assert(keysmash.isKeySmash("AKXFDJSKAHFKLDHAZSJAGQKJDHFJKS"))
assert(keysmash.isKeySmash("YESSSHFDHQJKLDSHGJXSFG"))

```

👉👈
