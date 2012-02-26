namespace :compile do

  desc "Compile the files"

  task :compile  do
   `dmd -lib bio/sequence/fasta.d -ofbuild/fasta.a`
   `dmd read_fasta.d build/fasta.a -odbuild -ofreadfasta`
  end
end

