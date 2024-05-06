#!/bin/bash

#
#
# By O. Echevarria
# Purpose: to create a skeleton WordPress theme
#
#

createBaseDirs(){
	
	dirname=$1
	dirnames=("images" "js" "css" "customizer" "incl")
	
	mkdir $dirname
	
	if [ -e $dirname ]; then
		
		echo "Directory $dirname has been created"
		
		for subdir in ${dirnames[@]}; do
		
		mkdir $dirname/$subdir
		
		if [ -d $dirname/$subdir ]; then
			
			echo "Directory $dirname/$subdir has been created."
		else
			echo "Directory $dirname/$subdir could not be created"
		fi
			
		done
		
	else
		echo "Directory $dirname has not been created"
	fi
	
}

#createContent(){ }

createContentPieces(){
	
	theme=$1				  
	filepieces=("404" "archive" "audio" "author" "category" "comments" "gallery" "link" "quote" "page" "search" "single" "status" "video")					  
	
	for inf in ${filepieces[@]}; do
		
		if [ ! -f $theme/$inf.php ]; then
			
			touch $theme/$inf.php
			
			echo "<?php
/*
Template for $inf.php
Content: $inf
Theme Name: $theme
 */
			
?>
<?php get_header(); ?>
			
	<?php if(have_posts()) { ?>
	
	<?php while(have_posts()) { the_post(); ?>
	
	<?php get_template_part('content', '$inf'); ?>
	
	<?php } ?>
	
	<?php } else { ?>
	
	<?php get_template_part('content', '404'); ?>
	
	<?php } ?>
			
<?php get_footer(); ?>" > $theme/$inf.php
			
			
			if [ -f $theme/$inf.php ]; then
				
				echo "File $theme/$inf.php created"
				
				touch $theme/content-$inf.php
				
				if [ ! -f $theme/contnet-$inf.php ]; then
					
					echo "<?php /*
					
Template for content-$inf.php
File: $theme/content-$inf.php
Theme Name: $theme
					
*/ ?>
<?php the_title(); ?>
<?php the_content(); ?>" > $theme/content-$inf.php
					
					echo "Template file $theme/content-$inf.php has been populated and created"
				fi
				
			fi
			
		else
			
			echo "Could not create file $theme/inf.php"
			
		fi
		
	done
	
}

createIndexPage() {
	
	theme=$1
	
	if [ -d $theme ]; then
		
		echo "<?php
/**
 * The main template file
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 *
 * @link https://developer.wordpress.org/themes/basics/template-hierarchy/
 *
 * @package $theme
 * @subpackage main $theme
 * @since 1.0
 * Taken from twentynineteen/index.php
 */
get_header();
?>
    <div id=\"primary\" class=\"content-area\">
        <main id=\"main\" class=\"site-main\">
<?php if ( have_posts() ) {
    // Load posts loop.
    
	while ( have_posts() ) { the_post();
    
	get_template_part( 'content', get_post_type() );
    
	}
	} else {
    // If no content, include the \"No posts found\" template.
    
	get_template_part( 'content', '404' );
    }
?>
		</main><!-- .site-main -->
    </div><!-- .content-area -->
<?php get_footer(); ?>" > $theme/index.php
		
		if [ -f $theme/index.php ]; then
			
			echo "The file $theme/index.php hs been created"
		fi
		
	fi
	
}

createStylesFile (){
	
	theme=$1
	
	if [ -d $theme ]; then
		
		touch $theme/style.css
		
		if [ -f $theme/style.css ]; then
		
		echo "@charset "UTF-8";
/*
Theme Name: $theme
Theme URI: 
Author: 
Author URI: 
Description: 
Requires at least: WordPress 5.0
Requires PHP: 5+
Version: 1.0
License: GNU General Public License v2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
Text Domain: $theme-domain
Tags: 
*/		
" > $theme/style.css
		
		echo "File style.css has been created"

		else
		
		echo "Could not create style.css file"	
		
		fi
		
	else
		
		echo "Could not create file, theme directory does not exist. "
		
	fi
	
}

createFunctionsFile (){
	
	theme=$1
	
	if [ -d $theme ]; then
		
		touch $theme/functions.php
		
		if [ -f $theme/functions.php ]; then
			
			echo "<?php // functions.php file
			
// insert functions here
" > $theme/functions.php

		echo "File $theme/functions.php has been created"

		else
			
			echo "Could not create $theme/functions.php file"
			
		fi
		
	fi
	
}

createHeaderFile (){
	
	theme=$1
	
	if [ -d $theme ]; then
	
	echo "<?php
/**
 * The header for our theme
 *
 * This is the template that displays all of the <head> section and everything up until <div id="content">
 *
 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
 *
 * @package $theme
 * @subpackage 
 * @since 1.0
 */
?><!doctype html>
<html <?php language_attributes(); ?>>
<head>
        <meta charset=\"<?php bloginfo( 'charset' ); ?>\" />
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
        <link rel=\"profile\" href=\"https://gmpg.org/xfn/11\" />
        <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php // insert header code here and below ?>
" > $theme/header.php
		if [ -f $theme/header.php ]; then
			
			echo "File $theme/header.php has been created "
		else
			echo "File $theme/header could not be created "
		fi
	fi
}

createFooterFile (){
	
	theme=$1
	
	if [ -d $theme ]; then

	touch $theme/footer.php
	
		if [ -f $theme/footer.php ]; then

	
echo "<?php
/**
 * The footer for our theme
 *
 * This is the template that displays all of the <head> section and everything up until <div id="content">
 *
 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
 *
 * @package $theme
 * @subpackage 
 * @since 1.0
 */
?>
<?php // insert footer code here and below ?>
<?php wp_footer(); ?>
</body>
</html>
" > $theme/footer.php
			
			echo "File $theme/footer.php has been created "
		else
			echo "File $theme/footer.php could not be created "
		fi
	fi
}

createCustomizerDat (){
	
	theme=$1
	
	if [ -d $theme ]; then
		
	# mkdir $theme/customizer
	
		if [ -d $theme/customizer ]; then
			
		touch $theme/customizer/index.php
		
		if [ -f $theme/customizer/index.php ]; then
			
			echo "File $theme/customizer/index.php has been created"
			
		fi
		
		touch $theme/customizer/customizer.php
		
			if [ -f $theme/customizer/customizer.php ]; then
				
				echo "<?php // place customizer code below " > $theme/customizer/customizer.php
				echo "File $theme/customizer/customizer.php has been created"
				
			fi
		fi
	else
		
		echo "Could create directory, $theme does not exist."
	fi
	
}

# start script

read -p "Enter name of theme directory you wish to create ==> " themedir

if  [ ! -d $themedir ]; then
	
	createBaseDirs $themedir
	
	if [ -d $themedir ]; then

	createIndexPage $themedir
		
	createContentPieces $themedir
	
	createStylesFile $themedir
	
	createFunctionsFile $themedir
	
	createHeaderFile $themedir
	
	createFooterFile $themedir
	
	createCustomizerDat $themedir
	
	fi

#	read -p "Enter the name of theme ==> " themename
	
else
	
	echo ""
	echo "Error: The directory $themedir already exists; please choose another name. "
	echo ""
	
fi
