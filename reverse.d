import std.stdio;
import std.string;
import std.conv;
import bio.sequence.dna;


void main(string[] args){
  if(args.length > 1) {

  dna_sequence str;
  dna_sequence complemented;
  dna_sequence types;

    str = to_dna(args[1]);
    
    foreach(residue; str.reverse){
      complemented ~= complement(residue);
      types ~= get_type(residue);

    }

    writefln(cast(string)(complemented));
    //writefln(cast(string)(types));
  }
}
