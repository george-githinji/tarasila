import std.stdio;
import std.string;
import std.conv;
import bio.sequence.dna;


void main(string[] args){
  if(args.length > 1) {

  dna_sequence s;
  dna_sequence c;

    s = to_dna(args[1]);
    
    foreach(n; s.reverse){
      c ~= complement(n);
    }

    writefln(cast(string)(c));
  }
}
