/* FACTS */
/* quest(X, Y, Z): mengumpulkan X item hasil panen, Y ikan, dan Z item hasil ranching */
:- dynamic(quest/3).
/* questRemaining(A, B, C, D): A, B, C, D menggambarkan 4 quest yang ada di map, bernilai satu jika quest nya masih ada */
:- dynamic(questRemaining/4).

/* RULES */