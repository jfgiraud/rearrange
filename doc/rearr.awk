function to_index(field) {
    if (field ~ /^[0-9]+$/) {
        idx = field;
        if (idx > NF || idx == 0) {
            printf "Error: Invalid column number #%s (min=1, max=%s) [field=%s]\n", idx, NF, field > "/dev/stderr";
            exit 1;
        }
        return idx;
    } else if (field ~ /^-[0-9]+$/) {
        idx = NF+field+1;
        if (idx > NF || idx < 1) {
            printf "Error: Invalid column number #%s (min=1, max=%s) [field=%s]\n", idx, NF, field > "/dev/stderr";
            exit 1;
        }
        return idx;
    }
    printf "Error: Invalid field [%s]\n", field > "/dev/stderr";
    exit 1;
}

BEGIN {
    split(list, FIELDSARR, ",");
}

{
    if ($0 !~ FS) {
        if (ONLY_DELIMITED ~ /0/) {
            print $0;
        }
        next;
    }

    first=1
    for (r in FIELDSARR) {
        if (first == 0) {
            printf "%s", OFS;
        } else {
            first = 0;
        }
        #print "r=" r " => " FIELDSARR[r] > "/dev/stderr";
        if (FIELDSARR[r] ~ /^[0-9]+$/ || FIELDSARR[r] ~ /^-[0-9]+$/) {
            idx = to_index(FIELDSARR[r]);
            printf "%s", $idx;
        } else if (FIELDSARR[r] ~ /^((-)?[0-9]+)?:((-)?[0-9]+)?$/) {
            split(FIELDSARR[r], tab, ":");
            from = to_index(tab[1] ~ /^$/ ? 1 : tab[1]);
            to = to_index(tab[2] ~ /^$/ ? NF : tab[2]);
            for (i=from; i<=to; i++) {
                printf "%s", $i;
                if (i != to) {
                    printf "%s", OFS;
                }
            }
            #printf "from=%s to=%s\n", from, to > "/dev/stderr";
        } else {
            printf "Error: Invalid syntax [field=%s]\n", FIELDSARR[r] > "/dev/stderr";
        }
    }
    printf "%s", ORS;
}