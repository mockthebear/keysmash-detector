# KeySmash-Detector

Detect if the word is a keysmash or not. 
Returns (**BOOLEAN**, Reason:**STRING**, Score:**FLOAT**)

# Usage

Syntax isKeySmash(<string>)

```lua
assert(not isKeySmash("cake"))
assert(not isKeySmash("useful"))
assert(not isKeySmash("pneumonoultramicroscopicsilicovolcanoconiosis"))
assert(not isKeySmash("aeuhehuaehauehuaehaueh"))
assert(not isKeySmash("KOPASKSPOAKSPOKSOPAKSPOAKSPOA"))

assert(isKeySmash("klashjdlkjsdhfjklsdh"))
assert(isKeySmash("ASLKDJSALKDJASLKDJASLK"))
assert(isKeySmash("goodnessalsdgkwnlzkgjkssd"))
assert(isKeySmash("AKXZNVJLKKSALDFKALD"))
assert(isKeySmash("AKXFDJSKAHFKLDHAZSJAGQKJDHFJKS"))
assert(isKeySmash("YESSSHFDHQJKLDSHGJXSFG"))

```

👉👈
