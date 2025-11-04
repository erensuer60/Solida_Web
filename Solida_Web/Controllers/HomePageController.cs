using Microsoft.AspNetCore.Mvc;

namespace Solida_Web.Controllers
{
	public class HomePageController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
		public IActionResult HeaderPartial()
		{
			return View();
		}
		public IActionResult ServicesPartial()
		{
			return View();
		}
		public IActionResult WhoWeArePartial()
		{
			return View();
		}
		public IActionResult ProjectPartial()
		{
			return View();
		}
		public IActionResult ContactPartial()
		{
			return View();
		}
		public IActionResult TestimonialPartial()
		{
			return View();
		}
		public IActionResult LatestNewPartial()
		{
			return View();
		}
		public IActionResult FooterPartial()
		{
			return View();
		}

	}
}
