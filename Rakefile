namespace :compile do

  desc "Compile executable files"
  task :compile  do
   zsh "dmd -lib bio/sequence/fasta.d -ofbuild/fasta.a"
   zsh "dmd read_fasta.d build/fasta.a -odbuild -ofreadfasta"
  end
end

