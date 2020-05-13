/*
PLAN:
two button, when you press either previous/next page,
either one will add/subtract from pageIndexReal then start a tween
that fades out the current page and then scales the
backdrop to the pageIndexReal sprites width and height
when the backdrop tween is complete, run event_user(0) (setting the pageindex)
and then fade in the sprite.

the page is drawn using pageIndex as index

*/

if (totalPages <= 0) exit;
if (con_books.bookListSurfX != -WINDOW[X]) exit;
if (con_books.bookSelected = noone) exit;