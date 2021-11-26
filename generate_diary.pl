/* buat nambahin facts diary biar ga manual */

generateDiary(0) :- !.
generateDiary(X) :-
    X >0,
    open('diary.pl',append,Stream),
    format(Stream,'diaryFile(~d,\'~d.txt\').~n',[X,X]),
    close(Stream),
    main(X-1).

