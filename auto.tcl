proc check_file_in_dirs {search_dir target_file} {
    set found_files {}
    
    # Recursively search through all directories
    foreach item [glob -nocomplain -directory $search_dir *] {
        if {[file isdir $item]} {
            # Recursively check subdirectories
            set results [check_file_in_dirs $item $target_file]
            set found_files [concat $found_files $results]
        }
        
        if {[file tail $item] eq $target_file} {
            lappend found_files $item
        }
    }
    
    return $found_files
}

# Usage Example
set search_path "C:/Users/Dell/Desktop/VLSI_PRAC"
set file_to_find "*.v"

set results [check_file_in_dirs $search_path $file_to_find]

if {[llength $results] > 0} {
    puts "Found files:"
    foreach file $results {
        puts "  $file"
    }
} else {
    puts "No files found matching: $file_to_find"
}