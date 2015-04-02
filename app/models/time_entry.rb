class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :case
  has_one :firm
  CHARGE_TYPES = ['hourly', 'fixed fee', 'contingent', 'no charge', 'non-billable']
  ABA_CODES = {
      'L100 Case Assessment, Development and Administration' => [
          ['L110 Fact Investigation/Development', 'L110'],
          ['L120 Analysis/Strategy', 'L120'],
          ['L130 Experts/Consultants', 'L130'],
          ['L140 Document/File Management', 'L140'],
          ['L150 Budgeting', 'L150'],
          ['L160 Settlement/Non-Binding ADR', 'L160'],
          ['L190 Other Case Assessment, Development and Administration', 'L190']
      ],
      'L200 Pre-Trial Pleadings and Motions' => [
          ['L210 Pleadings', 'L210'],
          ['L220 Preliminary Injunctions/Provisional Remedies', 'L220'],
          ['L230 Court Mandated Conferences', 'L230'],
          ['L240 Dispositive Motions', 'L240'],
          ['L250 Other Written Motions and Submissions', 'L250'],
          ['L260 Class Action Certification and Notice', 'L260']
      ],
      'L300 Discovery' => [
          ['L310 Written Discovery', 'L310'],
          ['L320 Document Production', 'L320'],
          ['L330 Depositions', 'L330'],
          ['L340 Expert Discovery', 'L340'],
          ['L350 Discovery Motions', 'L350'],
          ['L390 Other Discovery', 'L390']
      ],
      'L400 Trial Preparation and Trial' => [
          ['L410 Fact Witnesses', 'L410'],
          ['L420 Expert Witnesses', 'L420'],
          ['L430 Written Motions and Submissions', 'L430'],
          ['L440 Other Trial Preparation and Support', 'L440'],
          ['L450 Trial and Hearing Attendance', 'L450'],
          ['L460 Post-Trial Motions and Submissions', 'L460'],
          ['L470 Enforcement', 'L470']
      ],
      'L500 Appeal' => [
          ['L510 Appellate Motions and Submissions', 'L510'],
          ['L520 Appellate Briefs', 'L520'],
          ['L530 Oral Argument', 'L530']
      ],
      'A100 Activities' => [
          ['A101 Plan and prepare for', 'A101'],
          ['A102 Research', 'A102'],
          ['A103 Draft/revise', 'A103'],
          ['A104 Review/analyze', 'A104'],
          ['A105 Communicate (in firm)', 'A105'],
          ['A106 Communicate (with client)', 'A106'],
          ['A107 Communicate (other outside counsel)', 'A107'],
          ['A108 Communicate (other external)', 'A108'],
          ['A109 Appear for/attend', 'A109'],
          ['A110 Manage data/files', 'A110'],
          ['A111 Other', 'A111']
      ],
      'E100 Expenses' => [
          ['E101 Copying', 'E101'],
          ['E102 Outside printing', 'E102'],
          ['E103 Word processing', 'E103'],
          ['E104 Facsimile', 'E104'],
          ['E105 Telephone', 'E105'],
          ['E106 Online research', 'E106'],
          ['E107 Delivery services/messengers', 'E107'],
          ['E108 Postage', 'E108'],
          ['E109 Local travel', 'E109'],
          ['E110 Out-of-town travel', 'E110'],
          ['E111 Meals', 'E111'],
          ['E112 Court fees', 'E112'],
          ['E113 Subpoena fees', 'E113'],
          ['E114 Witness fees', 'E114'],
          ['E115 Deposition transcripts', 'E115'],
          ['E116 Trial transcripts', 'E116'],
          ['E117 Trial exhibits', 'E117'],
          ['E118 Litigation support vendors', 'E118'],
          ['E119 Experts', 'E119'],
          ['E120 Private investigators', 'E120'],
          ['E121 Arbitrators/mediators', 'E121'],
          ['E122 Local counsel', 'E122'],
          ['E123 Other professionals', 'E123'],
          ['E124 Other', 'E124'],
      ]
  }
end