// Define the tour!
    var tour = {
      id: "hello-hopscotch",
      steps: [
        {
          title: "Case Management",
          content: "This is where you can find all your case data including case details, contacts, task lists, and case notes.",
          target: "first",
          placement: "right",
        },
         {
          title: "Case Evaluation",
          content: "What's this case worth? Case Evaluation allows you to enter case information and get an expected value range. Share this with the client or save to the case file.",
          target: "CaseEval",
          placement: "right",
          showPrevButton: true,
        },
        {
          title: "Legal Insights",
          content: "Unique to Litigo is Legal Insights. Here you can visually research case values, view judge awards, and view attorney and practice statistics.",
          target: "second",
          placement: "right",
          showPrevButton: true,
        },
         {
          title: "Billing",
          content: "Create great looking invoices, track outstanding bills, and follow up to increase collections and get paid.",
          target: "bill",
          placement: "right",
          showPrevButton: true,
        },
         {
          title: "Profile",
          content: "Manage your profile including name, firm, and address. From here you can also invite additional users and manage your imported accounts.",
          target: "profile",
          placement: "right",
          showPrevButton: true,
        },
      ]
    };

addClickListener = function(el, fn) {
  if (el.addEventListener) {
    el.addEventListener('click', fn, false);
  }
  else {
    el.attachEvent('onclick', fn);
  }
},

init = function() {
  var startBtnId = 'startTourBtn',
      calloutId = 'startTourCallout',
      mgr = hopscotch.getCalloutManager(),
      state = hopscotch.getState();


  addClickListener(document.getElementById(startBtnId), function() {
    if (!hopscotch.isActive) {
      mgr.removeAllCallouts();
      hopscotch.startTour(tour);
    }
  });
};