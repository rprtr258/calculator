#include <stdio.h>

int func(int t, int c, char *s) {
    int res = 0;
    if (t == 0) {
        func(-61, s[0], "!ek;dc i@bK'(q)-[w]*%n+r3#l,{}:\nuwloca-O;m .vpbks,fxntdCeghiry");
        res = (s[0] == '/' || func(0, 300, s + 1));
    }
    if (t > 1 && t != 2) {
        if (t < c) {
            func(t + 1, c, s);
        }
        func(-94, t - 27, s);
    } else if (t < 0) {
        if (t < -72) {
            res = func(c, t, "@n'+,#'/*{}w+/w#cdnr/+,{}r/*de}+,/*{*+,/w{%+,/w#q#n+,/#{l,+,/n{n+,/+#n+,/#;#q#n+,/+k#;*+,/'r :'d*'3,}{w+K w'K:'+}e#';dq#'l q#'+d'K#!/+k#;q#'r}eKK#}w'r}eKK{nl]'/#;#q#n'){)#}w'){){nl]'/+#n';d}rw' i;# ){nl]!/n{n#'; r{#w'r nc{nl]'/#{l,+'K {rw' iK{;[{nl]'/w#q#n'wk nw' iwk{KK{nl]!/w{%'l##w#' i; :{nl]'/*{q#'ld;r'}{nlwb!/*de}'c ;;{nl'-{}rw]'/+,}##'*}#nc,',#nw]'/+kd'+e}+;#'rdq#w! nr'/ ') }+}{rl#'{n' ')# }'+}##(!!/");
        } else {
            if (t < -50) {
                if (c == s[0]) {
                    res = putchar(s[31]);
                } else {
                    res = func(-65, c, s + 1);
                }
            } else {
                res = func((s[0] == '/') + t, c, s + 1);
            }
        }
    }
    return res;
}

void printVerse(int c) {
    func(-79, 0, 0); // "On the "
    func(-87, 1 - c, 0); // day number
    func(-86, -13, 0); // " day of Christmas my true love gave to me\n"
    if (2 < c) {
        func(2 + 1, c, 0); // presents
    }
    func(-94, 2 - 27, 0); // "a partridge in a pear tree.\n\n"
    if (c < 13) {
        printVerse(c + 1);
    }
}
 
int main() {
    printVerse(2);
    return 0;
}