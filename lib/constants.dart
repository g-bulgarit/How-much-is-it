// This file holds all things constant to be used in the code.
// I take *no responsibilty* for shitty conversions,
// in fact, I blame the reader.

final convertFrom = {
  "power": {
    "watts": 1,
    "watt": 1,
    "horsepower": 5,
    "hp": 5,
    "megawatt": 1000,
    "megawatts": 1000,
    "gigawatts": 1000000,
    "gigawatt": 1000000,
  },
  "energy": {
    "joule": 1,
    "joules": 1,
    "electron volt": 1,
    "electron volts": 1,
    "kcal": 4200,
    "kilo calories": 4200,
    "calorie": 4200,
    "calories": 4200,
    "watt hours": 0.0002777778,
    "watt-hours": 0.0002777778,
    "btu": 0.0009478171,
  },
  "length": {
    "meters": 1,
    "meter": 1,
    "m": 1,
    "milimeter": 0.001,
    "milimeters": 0.001,
    "mm": 0.001,
    "centimeters": 0.01,
    "centimeter": 0.01,
    "cm": 0.01,
    "kilometers": 1000,
    "kilometer": 1000,
    "km": 1000,
    "miles": 1600,
    "mile": 1600,
    "inches": 39.37,
    "inch": 39.37,
    "foot": 3.28084,
    "feet": 3.28084,
    "yards": 1.093613,
    "yard": 1.093613,
    "nautical miles": 0.0005399568,
    "nautical mile": 0.0005399568,
  },
  "volume": {
    "litre": 1,
    "liter": 1,
    "liters": 1,
    "litres": 1,
    "mililitres": 0.001,
    "mililiters": 0.001,
    "mililiter": 0.001,
    "mililitre": 0.001,
    "floz": 0.0295735,
    "pint": 0.473,
    "pints": 0.473,
    "gallons": 3.78541,
  },
  "mass": {
    "kilogram": 1,
    "kilograms": 1,
    "kg": 0.001,
    "gram": 0.001,
    "grams": 0.001,
    "g": 0.001,
    "gr": 0.001,
    "tonnes": 1000,
    "tons": 1000,
    "ton": 100,
    "pounds": 2.20462,
    "lbs": 2.20462,
    "ounces": 35.27396195,
    "oz": 35.27396195,
  },
  "velocity": {
    "meters per second": 1,
    "kilometers per hour": 3.6,
    "kmh": 3.6,
    "km/h": 3.6,
    "miles per hour": 2.23694,
    "mph": 2.23694,
    "mp/h": 2.23694,
  },
  "force": {"newtons": 1, "newton": 1, "pounds force": 4.44822, "lbf": 4.44822},
  "pressure": {
    "pascal": 1,
    "pascals": 1,
    "psi": 0.000145038,
    "pounds per square inch": 0.000145038,
  },
  "time": {
    "seconds": 1,
    "second": 1,
    "s": 1,
    "minutes": 60,
    "minute": 60,
    "min": 60,
    "hours": 3600,
    "hour": 3600,
    "days": 86400,
    "day": 86400,
    "years": 31536000,
    "year": 31536000,
  },
};

final convertTo = {
  "power": {
    "hamsters on a wheel": 0.4,
    "keystrokes on a keyboard (per second)": 0.0015,
    "AA batteries (per hour)": 3.9,
    "washing machines": 500,
    "(rather average) microwaves": 800,
  },
  "energy": {
    "times the recoil from an AK47 shot": 2108,
    "times the energy released from lighting a fart on fire": 511,
    "the energy consumed in one hour of sleep": 376560,
    "times the energy consumption of New York City per hour": 39600000000000,
  },
  "length": {
    "times the length of an average banana": 0.1905,
    "times the width of a pinky finger": 0.0127,
    "times the length of your small intestine": 3.9624,
    "Boeing 747 jets, stacked cockpit to tail": 71,
    "times the length of a giraffe's tounge": 0.4826,
    "times the length of Chile": 4270000,
    "times the width of the Statue of Liberty's mouth": 0.9144,
    "times the length of Yonge street, Toronto, Canada": 1896000,
    "times the length of an emperor penguin's bill": 0.0762,
    "popsicle sticks": 0.1143,
    "times the length of Salvador Dali's moustache": 0.25,
    "times the length of a Southern Right whale's phallus": 3.6576,
    "times the maximum jump height of an NBA player (from standstill)": 0.9652,
    "times the height of the Burj Khalifa in Dubai": 830,
    "times the wingspan of a hummingbird": 0.11049,
  },
  "volume": {
    "times the total lung capacity of an adult male": 6,
    //  "first computer ever built":5 ,
    "ping-pong balls": 0.03351,
    "ripe eggplants": 0.41,
    "standard 6-sided dice": 0.00409,
    "marbles": 1 / 288,
    "times the volume of the sun": 1.4e30,
  },
  "mass": {
    "times the mass of the universe": 1.5 * 10e56,
    "times the mass of the average adult blue whale": 150000000,
    "times the mass of a single-ply toilet paper square": 0.0005,
    "(WW2) tiger-II tanks": 68500,
    "single dollar bills": 0.001,
    "times the mass of an anvil": 181.437,
    "snowflakes": 0.000003,
    "apple seeds": 0.00025,
    "peacock feathers": 0.3,
    "times that weight you pick up on holidays (on average)": 3.62874,
  },
  "velocity": {
    "times the record speed of the tortoise Bertie": 0.28,
    "times the average speed of an american rabbit": 15.6464,
    "times the record speed of Usain Bolt": 10.43,
    "times the fastest record pitch in baseball": 46.983904,
    "times the speed with which fingernails grow": 1.15741e-9,
    "times the average speed of a sloth": 0.0254,
    "times the speed of the flick of a snake's tounge": 3,
    "times the terminal velocity of a regulation bowling ball": 1.3,
    "times the record dive speed of a peregrine falcon": 108.183333,
    "times the speed of a camel-spider": 4.44,
    "times the speed of a garden snail": 0.0133,
  },
  "force": {
    "times the average professional boxer's punch": 3451.82,
    "times the force of an averge soccer kick": 1350,
    "times the force exerted by a raging bull": 5.41e8,
  },
  "pressure": {
    "times the pressure required to compress coffee as a barista": 51544.7,
    "times the pressure exerted by an elephant's step": 54000,
    //"times the pressure of an explosion's shockwave": -1,
    "times the pressure inside a Boeing 737's jet engine": 709275,
    "times the pressure inside a F16 jet engine": 2.533e6,
    "times the peak pressure exerted by an average human fart": 1013.5293,
  },
  "time": {
    "times the longest recorded flight of a chicken": 13,
    "times the average lifespan in indonesia": 2.24789e9,
    "times the time it takes to bake an apple pie": 4200,
    "times the pregnancy term of the common brown rat": 1.814e6,
    "times the half-life time of uranium": 1.4096592e17,
    "times the amount of time it takes you to sing the macarena": 254,
    "parts of the time it takes Uranus to complete a revolution around the sun":
        2.65136e9,
    "times the average time one spends picking his nose, per day": 252,
    "times the average life expectency of a mosquito": 604800,
    "times the runtime of the movie Shrek™": 5400,
    "times the runtime of the movie \'The Princess Bride\'": 5880,
    "times the runtime time of the entire Shrek™ franchise (movies 1 to 4)":
        22140,
  },
};

final subtextList = [
  "up to a constant",
  "...probably",
  "i wouldn't know",
  "but you should consult a professional",
  "don't try this at home",
  "...why?",
  "next time, use incognito for this",
  "who hurt you?",
  "look it up online",
  "look it up in a book",
  "get a second opinion",
  "did you really need to check?",
  "you should consult a proffesional",
  "or, at least, that's my honest opinion",
  "go share the knowledge!",
  "let your friends know",
  "every 5-yr old knows this already",
  "up to 16-bit float precision",
  "shouldn't your mom teach you this?",
  "where I come from, this is 3rd grade stuff",
  "clearly",
  "let's stop with the wine",
  "interesting",
  "easy to see",
  "one and one make two, two and one make three",
  "that's one you don't hear every day",
  "you learn something new every day",
  "but you'll forget this in a minute",
  "I'm not judging you",
  "in RMS, that is",
  "are you testing me?",
  "made from free-range bits",
  "the proof is left as an exercise to the reader",
  "last updated, June 1968",
  "that's what I heard",
  "(but don't tell anyone)",
  "shhh...",
  "but don't take it from me",
  "I failed to graduate from primary school",
  "I think.",
  "I hope this helps",
  "the FBI would like to know your location",
  "you shouldn't be doing these conversions",
  "I am somewhat of a genius myself",
  "01110000 01110010 01101111 01100010 01100001 01100010 01101100 01111001",
  "tehc",
  "maybe",
  "the cake is a lie",
  "approximated with Taylor",
  "to plot this, I would need more dimensions",
  "did I miss a minus sign?",
  "maybe put a low pass filter on it?",
  "plot it on a smith chart",
  "try using a bigger screw",
  "try using a *much* bigger screw",
  "I don't think you have a screw big enough for this",
  "in hexadecimal, that is",
  "try using a bigger bolt to secure that",
  "cool guys dont look at calculations",
  "nerd",
  "amazing how 20 years ago you'd need to ask an adult",
  "that's what a geek would look for",
  "calculated",
  "you may need a bigger wrench",
  "Hell yeah, science!",
  "I shit you not",
  "literally",
  "<mic drop>",
  "but I'm no engineer",
  "in the complex domain",
  "now put the gun down",
  "what would Newton say?",
  "whatever floats your boat",
  "whatever rustles your jimmies",
  "When life gives you lemons, make life take the lemons back",
  "Free admission on your next visit to the Dojo",
  "Ceci ñ'est pas une calcul",
  "save this for trivia night!",
  "this isn't easy",
  "get the pitchforks!",
  "with decent certainty",
  "this is harder than it looks",
  "I wouldn't bet on it",
  "next time, measure with bananas",
  "just smile and wave, boys",
  "[x] doubt",
  "expanded around x=0",
  "last time I checked",
];
