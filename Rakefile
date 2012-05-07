namespace :Executable do

  desc "Compile executable files"

  task :compile  do
   sh "dmd -lib bio/sequence/fasta.d -ofbuild/fasta.a"
   sh "dmd read_fasta.d build/fasta.a -odbuild -ofreadfasta"
   sh "dmd dbl_classifier.d build/fasta.a -odbuild -ofclassifier"
  end
end
