function triggerMouseEvent(node, eventType) {
    var clickEvent = document.createEvent("MouseEvents");
    clickEvent.initEvent(eventType, true, true);
    node.dispatchEvent(clickEvent);
}
function click(elem) {
    e = document.getElementById(elem);
    triggerMouseEvent(e, "mouseover");
    triggerMouseEvent(e, "mousedown");
    triggerMouseEvent(e, "mouseup");
    triggerMouseEvent(e, "click");
}
function click_start() {
    e = document.querySelector(".hd_closed.start");
    triggerMouseEvent(e, "mouseover");
    triggerMouseEvent(e, "mousedown");
    triggerMouseEvent(e, "mouseup");
    triggerMouseEvent(e, "click");
}
function restart() {
    e = document.getElementById("top_area_face");
    triggerMouseEvent(e, "click");
}
function getCell(cell) {
    if (cell.classList) {
        classList = Array.from(cell.classList);
        if (classList.includes("clear"))
            return -1;
        if (classList.includes("hd_closed"))
            return "x";
        for (let i = 0; i < 4; i++) {
            if (classList[i].startsWith("hd_type")) {
                if (classList[i].length == 9)
                    return "X";
                return classList[i].charAt(7);
            }
        }
    }
    return ""
}
function getBoard() {
    let res = [];
    let row = [];
    for (let el of document.getElementById("A43").children) {
        let x = getCell(el);
        if (x != -1)
            row.push(x);
        else {
            res.push(row);
            row = [];
        }
    }
    return res;
}
$$$ = (async() => {
	let restarted = false;
	click_start();
	let pos = await fetch("http://localhost:5000/set/mines_count?" + new URLSearchParams({
	    mines_count: W9.m20
	}), {
	    method: "GET"
	}).then(r => r.text());
    for (let i = 0; i < 100;i++) {
        while (true) {
            let pos = await fetch("http://localhost:5000/solve?" + new URLSearchParams({
                board: JSON.stringify(getBoard())
            }), {
                method: "GET"
            }).then(r => r.text());
            if (pos == "solved")
                break;
            click(`cell_${pos}`);
			restarted = false;
        }
		if (!restarted) {
			restart();
			restarted = true;
			click_start();
        }
    }
});
