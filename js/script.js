/* License, etc. */

$( function() {
    $( ".repo-btns" ).click( function( event ) {
        event.preventDefault();

        // Test button pressed and load appropriate repo if necessary
        var target = $( event.target ),
            repodiv = $( "#repodiv" ),
            repobtns = $( ".repo-btns" ),
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

        if ( repodiv.is( ":visible" ) ) {
            repodiv.hide( "slow", function() {
                if ( repodiv.data( "repo" ) != repoType ) {
                    repodiv.empty();
                    repodiv.show( function() {
                        $( window ).scrollTop( repodiv.offset().top );
                        repodiv.append( "<a href='http://github.com/" + repodiv.data( "link" ) + "target='_blank' class='ghlink'>View on GitHub</a>" );
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
            repodiv.show( "slow", function() {
                $( window ).scrollTop( repodiv.offset().top );
                if ( repodiv.data( "repo" ) != repoType ) {
                    repodiv.empty();
                    repodiv.append( "<a href='http://github.com/" + repodiv.data( "link" ) + "target='_blank' class='ghlink'>View on GitHub</a>" );
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
});
