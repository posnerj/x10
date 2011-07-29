package x10.hadoop;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import x10.interop.Java;

//import x10.hadoop.Job;
import x10.hadoop.Mapper;
import x10.hadoop.Reducer;

public class WordCount {

  public static class TokenizerMapper 
       extends Mapper[Object, Text, Text, IntWritable] {
    
    private static val one : IntWritable = new IntWritable(1);
    private val word = new Text();
      
    public def map(key:Object, value:Text, context:Context[Text,IntWritable]) {
      val itr = new StringTokenizer(value.toString());
      while (itr.hasMoreTokens()) {
        word.set(itr.nextToken());
        context.write(word, one);
      }
    }
  }
  
  public static class IntSumReducer 
       extends Reducer[Text,IntWritable,Text,IntWritable] {

    private val result = new IntWritable();

    public def reduce(key : Text, values : Iterable[IntWritable], context:Context[Text,IntWritable]) {
      var sum : Int = 0;
      for (v:IntWritable in values) {
        sum += v.get();
      }
      result.set(sum);
      context.write(key, result);
    }
  }

  public static def main(args:Array[String]) {
    val conf = new Configuration();
    val otherArgs = new GenericOptionsParser(conf, Java.convert(args)).getRemainingArgs();
    if (otherArgs.length != 2) {
      Console.ERR.println("Usage: wordcount <in> <out>");
      System.setExitCode(2);
      return;
    }
    val job = new Job[
	    WordCount, 		// application class
	    TokenizerMapper,	// mapper 
	    IntSumReducer,	// combiner 
	    IntSumReducer,	// reducer 
	    Text,		// output key 
	    IntWritable		// output value 
	](conf, "word count");
    FileInputFormat.addInputPath(job.get(), new Path(otherArgs(0)));
    FileOutputFormat.setOutputPath(job.get(), new Path(otherArgs(1)));
    System.setExitCode(job.get().waitForCompletion(true) ? 0 : 1);
  }
}