use warnings;
use strict;

open (my $raw, '<', 'interlinear.raw'  ) or die;
open (my $out, '>', 'interlinear.bibel') or die;

my $book;
my $verse;
my $chapter;

my $current_verse_text;

my $first_line = 1;

while (my $in = <$raw>) {

  chomp $in;

  if     ($in eq 'MATTHÄUS'         ) { $book = 'mt'   ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'MARKUS'           ) { $book = 'mk'   ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'LUKAS'            ) { $book = 'lk'   ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'JOHANNES'         ) { $book = 'joh'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'APOSTELGESCHICHTE') { $book = 'apg'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'RÖMER'            ) { $book = 'roem' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '1.KORINTHER'      ) { $book = '1kor' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '2.KORINTHER'      ) { $book = '2kor' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'GALATER'          ) { $book = 'gal'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'EPHESER'          ) { $book = 'eph'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'PHILIPPER'        ) { $book = 'phil' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'KOLOSSER'         ) { $book = 'kol'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '1.THESSALONICHER' ) { $book = '1thes';  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '2.THESSALONICHER' ) { $book = '2thes';  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '1.TIMOTHEUS'      ) { $book = '1tim' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '2.TIMOTHEUS'      ) { $book = '2tim' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'TITUS'            ) { $book = 'tit'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'PHILEMON'         ) { $book = 'phil' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'HEBRÄER'          ) { $book = 'hebr' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'JAKOBUS'          ) { $book = 'jak'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '1.PETRUS'         ) { $book = '1petr';  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '2.PETRUS'         ) { $book = '2petr';  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '1.JOHANNES'       ) { $book = '1joh' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '2.JOHANNES'       ) { $book = '2joh' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq '3.JOHANNES'       ) { $book = '3joh' ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'JUDAS'            ) { $book = 'jud'  ;  $chapter = 1; $verse = 0; next}
  elsif  ($in eq 'OFFENBARUNG'      ) { $book = 'offb' ;  $chapter = 1; $verse = 0; next}
  

  if ($in =~ /(\d+) *(.*$)/) {

    $current_verse_text = $2;

    if ($book eq '1kor' and $chapter == 13 and $1 == 14) {

      $chapter = 14;
      $verse   =  1;
      print $out "\n$book-$chapter-$verse|$current_verse_text";

    }
    elsif ($book eq 'offb' and $chapter == 15 and $1 == 16) {

      $chapter = 16;
      $verse   =  1;
      print $out "\n$book-$chapter-$verse|$current_verse_text";
    }
    elsif ($book eq 'offb' and $chapter == 20 and $1 == 21) {

      $chapter = 21;
      $verse   =  1;
      print $out "\n$book-$chapter-$verse|$current_verse_text";
    }
    elsif ($1 > $verse) {

      die "book = $book, chapter = $chapter, \$1 = $1, verse = $verse" unless $1 == $verse +1;

      $verse = $1;
      print $out "|\n" unless $first_line;
      $first_line = 0;
      print $out "$book-$chapter-$verse|$current_verse_text";

    }
    else {
      print $out "|\n";

      $chapter ++;
      
      die "book: $book chapter: $chapter, \$1 = $1" unless $chapter == $1;
      $verse   = 1;

      print $out "$book-$chapter-$verse|$current_verse_text";
    }

  }
  else {
     print $out " $in";
  }


}
