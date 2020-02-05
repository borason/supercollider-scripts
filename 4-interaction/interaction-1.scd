(
var w;

w = Window("My Window", Rect(100, 500, 200, 200));

w.front;
)

(
var w, slid;

w = Window("My Window", Rect(100, 500, 200, 100));

slid = Slider(w, Rect(10, 10, 180, 40));

slid.action_({slid.value.postIn;});

w.front;

)

