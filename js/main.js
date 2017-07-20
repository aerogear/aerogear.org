window.onload = function(){

	var slideMenuButton = document.getElementById('slide-menu-button');
	slideMenuButton.onclick = function(e) {
		var site = document.getElementById('site');
        var sideNav = document.getElementById('sideNav');
		var cl = site.classList;
        var sideNavCl = sideNav.classList;
		if (cl.contains('open')) {
			cl.remove('open');
            sideNavCl.add('hidden');
		} else {
			cl.add('open');
            sideNavCl.remove('hidden');
		}
	};
}