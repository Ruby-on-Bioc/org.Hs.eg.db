# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

# ensure extdata files exist
task :ensure_extdata do
  [bioc_sqlite_database_name, "DESCRIPTION"].each do |file|
    raise "Missing file: #{file}" unless File.exist?("extdata/#{file}")
  end
end

Rake::Task["build"].enhance [:ensure_extdata]

task default: :test

def bioc_version
  "release"
end

def bioc_sqlite_database_name
  ""
end

def bioc_package_name
  "org.Hs.eg.db"
end

def bioc_package_version
  "3.15.0"
end

def bioc_package_md5sum
  "8d3d0d5d1e37d240d74cb9ad9a0ba05a"
end

def bioc_package_sha256sum
  ""
end

def bioc_package_file_name
  "#{bioc_package_name}_#{bioc_package_version}.tar.gz"
end

def gem_require_name
  "org_hs_eg_db"
end

def download_annotation(src, database, file, md5sum, sha256)
  require "fileutils"
  require "open-uri"
  require "tmpdir"

  url = "https://bioconductor.org/packages/#{bioc_version}/data/annotation/src/contrib/#{file}"
  puts "Downloading #{url}"
  contents = URI.open(url).read

  unless md5sum == ""
    computed_md5sum = Digest::MD5.hexdigest(contents)
    raise "MD5 checksum mismatch for #{url}" unless md5sum == computed_md5sum
  end

  unless sha256 == ""
    computed_sha256 = Digest::SHA256.hexdigest(contents)
    raise "SHA256 checksum mismatch for #{url}" unless sha256 == computed_sha256
  end


  Dir.chdir(Dir.mktmpdir) do
    File.binwrite(file, contents)
    command = "tar xf"
    system "#{command} #{file}"
    dest = File.expand_path("extdata", __dir__)

    FileUtils.mkdir_p(dest)

    if database == ""
      databases = Dir.glob("#{src}/inst/extdata/*.sqlite")
      raise "No database found in #{src}/inst/extdata" if databases.empty?
      raise "Multiple databases found in #{src}/inst/extdata" if databases.size > 1

      database = File.basename(databases.first)
      require_path = File.expand_path("lib/#{gem_require_name}.rb", __dir__)
      str = File.read(require_path)
                .sub!("*", File.basename(database, ".sqlite"))
      File.write(require_path, str)
    end

    FileUtils.cp("#{src}/inst/extdata/#{database}", "#{dest}/#{database}")
    puts "Saved extdata/#{database}"

    FileUtils.cp("#{src}/DESCRIPTION", "#{dest}/DESCRIPTION")
    puts "Saved extdata/DESCRIPTION"
  end
end

namespace :extdata do
  desc "download #{bioc_sqlite_database_name}"
  task :download do
    download_annotation(bioc_package_name,
                        bioc_sqlite_database_name,
                        bioc_package_file_name,
                        bioc_package_md5sum,
                        bioc_package_sha256sum)
  end
end
