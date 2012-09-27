/* License, etc. */

$( function() {
    $( ".repo-btns" ).click( function( event ) {
        event.preventDefault();

        // Test button pressed and load appropriate repo if necessary
        var target = $( event.currentTarget ),
            repodiv = $( "#repodiv" ),
            repoContainer = $( "#repo-container" ),
            repobtns = $( ".repo-btns" ),
            repolink = $( "#fork-link" ),
            body = $( "body" ),
            dataLink = target.data( "link" ),
            repoAr = dataLink.split( "/" ),
            repoName = repoAr[ 1 ], repoUser = "aerogear";

        repobtns.each( function() {
            var $this = $( this );
            $this.text( $this.data( "original-text" ) );
        });

        if ( repoContainer.is( ":visible" ) ) {
            repoContainer.hide( function() {
                if ( repodiv.data( "repo" ) != repoName ) {
                    repodiv.empty();
                    repoContainer.show( function() {
                        body.animate( { scrollTop: repoContainer.offset().top - 150 }, "slow");
                        repolink.attr( "href", "http://github.com/" + dataLink );
                        repodiv.repo({
                            user: repoUser,
                            name: repoName
                        });
                        target.text( "Hide Repo" );
                        repodiv.data( "repo", repoName );
                    });
                }
            });
        } else {
            repodiv.empty();
            repoContainer.show( function() {
                body.animate( { scrollTop: repoContainer.offset().top - 150 }, "slow");
                repolink.attr( "href", "http://github.com/" + dataLink );
                repodiv.repo({
                    user: repoUser,
                    name: repoName
                });
                target.text( "Hide Repo" );
                repodiv.data( "repo", repoName );
            });
        }
    });

    // Show Twitter Feed
    $( "#aerogear-twitter" ).twitter( { ors: "aerogear", replies: false, rpp: 7 } );

    // Initialize drop down menu
    $( ".dropdown-toggle" ).dropdown();

    // Dynamic fixed positioning for left nav
    if ( $( ".nav-box" ).length ) {
        $( window ).on( "scroll", function( event ) {
            var navBox = $(".nav-box"),
                navBottom = navBox.position().top + navBox.height(),
                footerTop = $("footer").position().top;

            navBox.css( "margin-top", navBottom > footerTop ? footerTop - navBottom - 5 : 0 );
        });
    }

    // Home Link
    $( ".banner-home-link" ).click( function( event ) {
        document.location.href = "/";
    });

    // Format notes and tips
    $( ".admonitionblock .icon .title:contains('Note'), .admonitionblock .icon .title:contains('Tip')" ).each( function() {
        var $this = $( this ),
            block = $this.closest( ".admonitionblock" );
        block.addClass( "note-tip-block" );
        block.find( ".content:eq(0)" ).addClass( "note-tip-content" );
        if ( $this.is( ".title:contains('Note')" ) ) {
            $this.replaceWith( "<i class='icon-pushpin note-tip-icon'></i>" );
        } else {
            $this.replaceWith( "<i class='icon-info-sign note-tip-icon'></i>" );
        }
    });
});
