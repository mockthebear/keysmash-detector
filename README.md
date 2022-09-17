# keysmash-detector
Detect if the word is a keysmash or not.

# Usage

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
