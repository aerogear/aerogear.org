/* License, etc. */

$( function() {
    $( ".repo-btns" ).click( function( event ) {
        event.preventDefault();

        // Test button pressed and load appropriate repo if necessary
        var target = $( event.target ),
            repodiv = $( "#repodiv" ),
            repoContainer = $( "#repo-container" ),
            repobtns = $( ".repo-btns" ),
            repolink = $( "#fork-link" ),
            body = $( "body" ),
            repoType, repoUser = "aerogear", repoName;

        if ( target.is( "#jsrepo-btn" ) ) {
            repoType = "js";
            repoName = "aerogear-js";
        } else if ( target.is( "#controllerrepo-btn" ) ) {
            repoType = "controller";
            repoName = "aerogear-controller";
        }

        repobtns.each( function() {
            var $this = $( this );
            $this.text( $this.data( "original-text" ) );
        });

        if ( repoContainer.is( ":visible" ) ) {
            repoContainer.hide( "slow", function() {
                if ( repodiv.data( "repo" ) != repoType ) {
                    repodiv.empty();
                    repoContainer.show( function() {
                        body.animate( { scrollTop: repoContainer.offset().top - 150 }, "slow");
                        repolink.attr( "href", "http://github.com/" + target.data( "link" ) );
                        repodiv.repo({
                            user: repoUser,
                            name: repoName
                        });
                        target.text( "Hide Repo" );
                    });
                    repodiv.data( "repo", repoType );
                }
            });
        } else {
            repoContainer.show( "slow", function() {
                body.animate( { scrollTop: repoContainer.offset().top - 150 }, "slow");
                if ( repodiv.data( "repo" ) != repoType ) {
                    repodiv.empty();
                    repolink.attr( "href", "http://github.com/" + target.data( "link" ) );
                    repodiv.repo({
                        user: repoUser,
                        name: repoName
                    });
                    target.text( "Hide Repo" );
                    repodiv.data( "repo", repoType );
                }
            });
        }
    });

    // Show Twitter Feed
    $( "#aerogear-twitter" ).twitter( { ors: "aerogear", replies: false, rpp: 7 } );

    // Initialize drop down menu
    $( ".dropdown-toggle" ).dropdown();
});
