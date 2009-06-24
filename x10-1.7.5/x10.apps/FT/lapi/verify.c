#include<stdio.h>
#include<math.h>
void checksum_verify (int d1, int d2, int d3, int nt, double *real_sums, double *imag_sums)
{
  /*--------------------------------------------------------------------
    c-------------------------------------------------------------------*/
  int i;
  double err, epsilon;
  int known_class = 0;
  int verified;
  /*--------------------------------------------------------------------
    c   Sample size reference checksums
    c-------------------------------------------------------------------*/

  /*--------------------------------------------------------------------
    c   Class S size reference checksums
    c-------------------------------------------------------------------*/
  double vdata_real_s[6 ] =
  {
   5.546087004964e+02,
   5.546385409189e+02,
   5.546148406171e+02,
   5.545423607415e+02,
   5.544255039624e+02,
   5.542683411902e+02};
  double vdata_imag_s[6 ] =
  {
   4.845363331978e+02,
   4.865304269511e+02,
   4.883910722336e+02,
   4.901273169046e+02,
   4.917475857993e+02,
   4.932597244941e+02};
  /*--------------------------------------------------------------------
    c   Class W size reference checksums
    c-------------------------------------------------------------------*/
  double vdata_real_w[6 ] =
  {
   5.673612178944e+02,
   5.631436885271e+02,
   5.594024089970e+02,
   5.560698047020e+02,
   5.530898991250e+02,
   5.504159734538e+02};
  double vdata_imag_w[6 ] =
  {
   5.293246849175e+02,
   5.282149986629e+02,
   5.270996558037e+02,
   5.260027904925e+02,
   5.249400845633e+02,
   5.239212247086e+02};
  /*--------------------------------------------------------------------
    c   Class A size reference checksums
    c-------------------------------------------------------------------*/
  double vdata_real_a[6] =
  {
   5.046735008193e+02,
   5.059412319734e+02,
   5.069376896287e+02,
   5.077892868474e+02,
   5.085233095391e+02,
   5.091487099959e+02};
  double vdata_imag_a[6 ] =
  {
   5.114047905510e+02,
   5.098809666433e+02,
   5.098144042213e+02,
   5.101336130759e+02,
   5.104914655194e+02,
   5.107917842803e+02};
  /*--------------------------------------------------------------------
    c   Class B size reference checksums
    c-------------------------------------------------------------------*/
  double vdata_real_b[20 ] =
  {
   5.177643571579e+02,
   5.154521291263e+02,
   5.146409228649e+02,
   5.142378756213e+02,
   5.139626667737e+02,
   5.137423460082e+02,
   5.135547056878e+02,
   5.133910925466e+02,
   5.132470705390e+02,
   5.131197729984e+02,
   5.130070319283e+02,
   5.129070537032e+02,
   5.128182883502e+02,
   5.127393733383e+02,
   5.126691062020e+02,
   5.126064276004e+02,
   5.125504076570e+02,
   5.125002331720e+02,
   5.124551951846e+02,
   5.124146770029e+02};
  double vdata_imag_b[20 ] =
  {
   5.077803458597e+02,
   5.088249431599e+02,
   5.096208912659e+02,
   5.101023387619e+02,
   5.103976610617e+02,
   5.105948019802e+02,
   5.107404165783e+02,
   5.108576573661e+02,
   5.109577278523e+02,
   5.110460304483e+02,
   5.111252433800e+02,
   5.111968077718e+02,
   5.112616233064e+02,
   5.113203605551e+02,
   5.113735928093e+02,
   5.114218460548e+02,
   5.114656139760e+02,
   5.115053595966e+02,
   5.115415130407e+02,
   5.115744692211e+02};
  /*--------------------------------------------------------------------
    c   Class C size reference checksums
    c-------------------------------------------------------------------*/
  double vdata_real_c[20 ] =
  {
   5.195078707457e+02,
   5.155422171134e+02,
   5.144678022222e+02,
   5.140150594328e+02,
   5.137550426810e+02,
   5.135811056728e+02,
   5.134569343165e+02,
   5.133651975661e+02,
   5.132955192805e+02,
   5.132410471738e+02,
   5.131971141679e+02,
   5.131605205716e+02,
   5.131290734194e+02,
   5.131012720314e+02,
   5.130760908195e+02,
   5.130528295923e+02,
   5.130310107773e+02,
   5.130103090133e+02,
   5.129905029333e+02,
   5.129714421109e+02};
  double vdata_imag_c[20 ] =
  {
   5.149019699238e+02,
   5.127578201997e+02,
   5.122251847514e+02,
   5.121090289018e+02,
   5.121143685824e+02,
   5.121496764568e+02,
   5.121870921893e+02,
   5.122193250322e+02,
   5.122454735794e+02,
   5.122663649603e+02,
   5.122830879827e+02,
   5.122965869718e+02,
   5.123075927445e+02,
   5.123166486553e+02,
   5.123241541685e+02,
   5.123304037599e+02,
   5.123356167976e+02,
   5.123399592211e+02,
   5.123435588985e+02,
   5.123465164008e+02};
  double vdata_real_d[25] =
  {
   5.122230065252e+02,
   5.120463975765e+02,
   5.119865766760e+02,
   5.119518799488e+02,
   5.119269088223e+02,
   5.119082416858e+02,
   5.118943814638e+02,
   5.118842385057e+02,
   5.118769435632e+02,
   5.118718203448e+02,
   5.118683569061e+02,
   5.118661708593e+02,
   5.118649768950e+02,
   5.118645605626e+02,
   5.118647586618e+02,
   5.118654451572e+02,
   5.118665212451e+02,
   5.118679083821e+02,
   5.118695433664e+02,
   5.118713748264e+02,
   5.118733606701e+02,
   5.118754661974e+02,
   5.118776626738e+02,
   5.118799262314e+02,
   5.118822370068e+02};
  double vdata_imag_d[25] =
  {
   5.118534037109e+02,
   5.117061181082e+02,
   5.117096364601e+02,
   5.117373863950e+02,
   5.117680347632e+02,
   5.117967875532e+02,
   5.118225281841e+02,
   5.118451629348e+02,
   5.118649119387e+02,
   5.118820803844e+02,
   5.118969781011e+02,
   5.119098918835e+02,
   5.119210777066e+02,
   5.119307604484e+02,
   5.119391362671e+02,
   5.119463757241e+02,
   5.119526269238e+02,
   5.119580184108e+02,
   5.119626617538e+02,
   5.119666538138e+02,
   5.119700787219e+02,
   5.119730095953e+02,
   5.119755100241e+02,
   5.119776353561e+02,
   5.119794338060e+02};
  
  epsilon = 1.0e-12;
  verified = 1;

  /* CLASS S*/
  if (d1 == 64 &&
      d2 == 64 &&
      d3 == 64 &&
      nt == 6)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_s[i]) / vdata_real_s[i];
          if (fabs (err) > epsilon)
            {

		verified = 0;
		break;
            }
          err = (imag_sums[i] - vdata_imag_s[i]) / vdata_imag_s[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }
  /*CLASS W*/
  else if (d1 == 128 &&
           d2 == 128 &&
           d3 == 32 &&
           nt == 6)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_w[i]) / vdata_real_w[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
          err = (imag_sums[i] - vdata_imag_w[i]) / vdata_imag_w[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }
  /*Class A*/
  else if (d1 == 256 &&
           d2 == 256 &&
           d3 == 128 &&
           nt == 6)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_a[i]) / vdata_real_a[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
          err = (imag_sums[i] - vdata_imag_a[i]) / vdata_imag_a[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }
  /*CLASS B*/
  else if (d1 == 512 &&
           d2 == 256 &&
           d3 == 256 &&
           nt == 20)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_b[i]) / vdata_real_b[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
          err = (imag_sums[i] - vdata_imag_b[i]) / vdata_imag_b[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }
  /*CLASS C*/
  else if (d1 == 512 &&
           d2 == 512 &&
           d3 == 512 &&
           nt == 20)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_c[i]) / vdata_real_c[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
          err = (imag_sums[i] - vdata_imag_c[i]) / vdata_imag_c[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }
  /*CLASS D*/
  else if (d1 == 2048 &&
           d2 == 1024 &&
           d3 == 1024 &&
           nt == 25)
    {
      known_class = 1;
      for (i = 0; i < nt; i++)
        {
          err = (real_sums[i] - vdata_real_d[i]) / vdata_real_d[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
          err = (imag_sums[i] - vdata_imag_d[i]) / vdata_imag_d[i];
          if (fabs (err) > epsilon)
            {
              verified = 0;
              break;
            }
        }
    }

  if (known_class && (verified))
    {
      printf (" 0>\t\tResult verification successful\n");
    }
  else
    {
      printf (" 0>\t\tResult verification failed\n");
    }
}
